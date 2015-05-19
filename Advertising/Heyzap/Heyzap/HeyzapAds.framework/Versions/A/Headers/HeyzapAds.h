/*
 * Copyright (c) 2015, Heyzap, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the name of 'Heyzap, Inc.' nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HZLog.h"
#import "HZInterstitialAd.h"
#import "HZVideoAd.h"
#import "HZIncentivizedAd.h"

#import "HZNativeAdController.h"
#import "HZNativeAdCollection.h"
#import "HZNativeAd.h"
#import "HZNativeAdImage.h"

#import "HZShowOptions.h"
#import "HZBannerAd.h"
#import "HZBannerAdOptions.h"

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#define SDK_VERSION @"8.2.1"

#if __has_feature(objc_modules)
@import AdSupport;
@import CoreGraphics;
@import CoreTelephony;
@import MediaPlayer;
@import QuartzCore;
@import StoreKit;
@import iAd;
@import MobileCoreServices;
@import Security;
#endif

typedef NS_ENUM(NSUInteger, HZAdOptions) {
    HZAdOptionsNone = 0 << 0,
    HZAdOptionsDisableAutoPrefetching = 1 << 0,
    HZAdOptionsAdvertiserOnly = 1 << 1,
    HZAdOptionsAmazon = 1 << 2,
    HZAdOptionsInstallTrackingOnly = 1 << 1,
    /**
     *  Pass this to disable mediation. This is not required, but is recommended for developers not using mediation. If you're mediating Heyzap through someone (e.g. AdMob), it is *strongly* recommended that you disable Heyzap's mediation to prevent any potential conflicts.
     */
    HZAdOptionsDisableMedation = 1 << 3,
};

/** The `HZAdsDelegate` protocol provides global information about our ads. If you want to know if we had an ad to show after calling `showAd` (for example, to fallback to another ads provider). It is recommend using the `showAd:completion:` method instead. */
@protocol HZAdsDelegate<NSObject>

@optional

#pragma mark - Showing ads callbacks

/**
 *  Called when we succesfully show an ad.
 *
 *  @param tag The identifier for the ad.
 */
- (void)didShowAdWithTag: (NSString *) tag;

/**
 *  Called when an ad fails to show
 *
 *  @param tag   The identifier for the ad.
 *  @param error An NSError describing the error
 */
- (void)didFailToShowAdWithTag: (NSString *) tag andError: (NSError *)error;

/**
 *  Called when a valid ad is received
 *
 *  @param tag The identifier for the ad.
 */
- (void)didReceiveAdWithTag: (NSString *) tag;

/**
 *  Called when our server fails to send a valid ad, like when there is a 500 error.
 *
 *  @param tag The identifier for the ad.
 */
- (void)didFailToReceiveAdWithTag: (NSString *) tag;

/**
 *  Called when the user clicks on an ad.
 *
 *  @param tag An identifier for the ad.
 */
- (void)didClickAdWithTag: (NSString *) tag;

/**
 *  Called when the ad is dismissed.
 *
 *  @param tag An identifier for the ad.
 */
- (void)didHideAdWithTag: (NSString *) tag;

/**
 *  Called when an ad will use audio
 */
- (void)willStartAudio;

/**
 *  Called when an ad will finish using audio
 */
- (void) didFinishAudio;

@end

/** The HZIncentivizedAdDelegate protocol provides global information about using an incentivized ad. If you want to give the user a reward
 after successfully finishing an incentivized ad, implement the didCompleteAd method */
@protocol HZIncentivizedAdDelegate<HZAdsDelegate>

@optional

/** Called when a user successfully completes viewing an ad */
- (void)didCompleteAdWithTag: (NSString *) tag;
/** Called when a user does not complete the viewing of an ad */
- (void)didFailToCompleteAdWithTag: (NSString *) tag;

@end

/**
 *  A class with miscellaneous Heyzap Ads methods.
 */
@interface HeyzapAds : NSObject

/**
 *  Sets the object to receive HZIncentivizedAdDelegate callbacks
 *
 *  @param delegate An object conforing to the HZIncentivizedAdDelegate protocol
 */
+ (void) setIncentiveDelegate: (id<HZIncentivizedAdDelegate>) delegate __attribute__((deprecated("Call `HZIncentivizedAd setDelegate:` instead.")));


/**
 *
 *
 */

+ (void) startWithPublisherID: (NSString *) publisherID andOptions: (HZAdOptions) options;
+ (void) startWithPublisherID:(NSString *)publisherID andOptions:(HZAdOptions)options andFramework: (NSString *) framework;
+ (void) startWithPublisherID: (NSString *) publisherID;

+ (BOOL) isStarted;
+ (void) setDebugLevel:(HZDebugLevel)debugLevel;
+ (void) setDebug:(BOOL)choice;
+ (void) setOptions: (HZAdOptions)options;
+ (void) setFramework: (NSString *) framework;
+ (void) setMediator: (NSString *) mediator;
+ (NSString *) defaultTagName;

/**
 * Presents a view controller that displays integration information and allows fetch/show testing
 */
+ (void)presentMediationDebugViewController;

@end
