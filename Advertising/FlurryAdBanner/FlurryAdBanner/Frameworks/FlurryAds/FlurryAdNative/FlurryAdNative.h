//
//  FlurryAdNative.h
//  Flurry iOS Advertising
//
//  Copyright 2009-2014 Flurry, Inc. All rights reserved.
//	
//	Methods in this header file are for use by Flurry Publishers

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FlurryAdNativeAsset.h"
#import "FlurryAdNativeDelegate.h"
#import "FlurryAdTargeting.h"

/*!
 *  @brief Provides all available methods for displaying native ads.
 * 
 *  Set of methods that allow publishers to configure, target, and deliver native ads to their customers.
 *
 *  For information on how to use Flurry's Ads SDK to
 *  attract high-quality users and monetize your user base see <a href="http://support.flurry.com/index.php?title=Publishers">Support Center - Publishers</a>.
 *
 *  @author 2009 - 2014 Flurry, Inc. All Rights Reserved.
 *  @version 6.0.0
 * 
 */
@interface FlurryAdNative : NSObject


/*!
 *  @brief Read only property that can be used to retrieve the ad space that was
 *  passed into an initializer routine. An Ad Space is an area within your app that is designated to display ads.
 *  Ad spaces need to be setup and configured on the Flurry developer portal.
 *  @since 6.0.0
 *
 *  @return The ad space string value.
 */
@property (nonatomic, readonly) NSString *space;

/*!
 *  @brief Sets the object to receive various delegate methods.
 *  @since 6.0.0
 *
 *  This method allows you to register an object that will receive
 *  notifications at different phases of native ad serving.
 *
 *  @see FlurryAdNativeDelegate for details on delegates available.
 *
 *  @code
    -(void) fetchNativeAd;
    {
        FlurryAdNative* nativeAd = [[FlurryAdNative alloc] initWithSpace:adSpace];
        nativeAd.adDelegate = self;
        nativeAd.viewControllerForPresentation = self;
        [nativeAd fetchAd];
    }
 *  @endcode
 *
 *  @param delegate The object to receive notifications of various ad actions.
 *
 */
@property (nonatomic, assign) id<FlurryAdNativeDelegate> adDelegate;

/*!
 *  @brief Returns if an ad is currently ready to display for this ad object
 *  @since 6.0.0
 *
 *  This method will verify if an ad is currently available for this ad object.
 *  If an ad is not available, you can call #fetchAd: to load a new ad.
 *
 *  @note If this method returns YES, an ad will be available and the assetList will be populated.
 *  It is advisable to listen to the delegate FlurryAdNativeDelegate#adNative:adError:errorDescription:
 *  to get notified if the ad fetch request fails.
 *
 *  @see #fetch for details on retrieving an ad.\n
 *
 *  @code
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    {
        // map table row to index within an array of prefetched native ads
        // isAdRow and adIndexForIndexPathRow will be methods defined in your code
        NSInteger adIx = [self adIndexForIndexPathRow:indexPath.row];
        if ([self isAdRow:indexPath.row] && [[self.nativeAds objectAtIndex:adIx] ready] == YES)
        {
            // AdCell here is a user defined class that will setup a xib view using the assets in a native ad
            AdCell* adCell = [tableView dequeueReusableCellWithIdentifier:@"FlurryStreamCell" forIndexPath:indexPath];
            FlurryAdNative* nativeAd = [self.nativeAds objectAtIndex:adIx];
            [adCell setupWithFlurryNativeAd:nativeAd atPosition:indexPath.row];
        }
        else
        {
            // setup app content xib cells
        }
    }
 *  @endcode
 *
 *  @return YES/NO to indicate if an ad is ready to be displayed.
 */
@property (nonatomic, readonly) BOOL ready;



/*!
 *  @brief Returns if an ad has expired
 *  @since 6.3.0
 *
 *  This method will verify if the ad associated with this native ad object has expired.
 *  Please call fetch again or discard this native ad object and create a new native object
 *  when the ad expires
 *
 *  @note a native ad object can expire after it is ready, so it is necessary to test for expiry 
 *  while the native ad is in use.
 *
 *  @see #fetchAd for details on retrieving an ad.\n
 *
 *  @code
 
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    {
        // map table row to index within an array of prefetched native ads
        // isAdRow and adIndexForIndexPathRow will be methods defined in your code
        NSInteger adIx = [self adIndexForIndexPathRow:indexPath.row];
        if ([self isAdRow:indexPath.row] && [[self.nativeAds objectAtIndex:adIx] ready] == YES)
        {
            // AdCell here is a user defined class that will setup a xib view using the assets in a native ad
            AdCell* adCell = [tableView dequeueReusableCellWithIdentifier:@"FlurryStreamCell" forIndexPath:indexPath];
 
            // check if ad has expired and then show or display ad cell as appropriate
            if ([[self.nativeAds objectAtIndex:adIx] expired] == YES)
            {
                // ad associated with this native ad object has expired, fetch a new ad
                FlurryAdNative* nativeAd = [self.nativeAds objectAtIndex:adIx];
                [nativeAd fetchAd];
 
                // hide ad cell until ad is available
                adCell.hidden = YES;
            }
            else
            {
                FlurryAdNative* nativeAd = [self.nativeAds objectAtIndex:adIx];
                [adCell setupWithFlurryNativeAd:nativeAd atPosition:indexPath.row];
                adCell.hidden = NO;
            }
        }
        else
        {
            // setup app content xib cells
        }
    }
 *  @endcode
 *
 *  @return YES/NO to indicate if an ad is ready to be displayed.
 */
@property (nonatomic, readonly) BOOL expired;

/*!
 *  @brief This property will retrieve the native ad's assets. The assets will be available when the ad is ready.
 *  @since 6.0.0
 *
 *  @see FlurryAdNativeAsset for details on the assets.\n
 *  
 *  @code
    for (int ix = 0; ix < adNative.assetList.count; ix++)
    {
        FlurryAdNativeAsset* asset = [adNative.assetList objectAtIndex:ix];
        if ([asset.name isEqualToString:@"headline"])
        {
            self.streamTitleLabel.text = asset.value;
        }
        if ([asset.name isEqualToString:@"summary"])
        {
            self.streamDescriptionLabel.text = asset.value;
        }
    }
 *  @endcode
 *
 *  @return Array of FlurryAdNativeAsset objects
 *
 */
@property (nonatomic, readonly) NSArray *assetList;

/*!
 *  @brief The UIView that needs click tracking
 *
 *  Set this property to track clicks on a view. For a table view controller
 *  the UITableViewCell that is used to display the ad can be set as the tracking view.
 *
 *  @note It is very important to set trackingView to nil or call FlurryAdNative#removeTrackingView before the ad cell is reused.
 *
 *  @since 6.0.0
 *
 *  @see #removeTrackingView
 *
 *  @code
 
    @interface AdStreamCell : UITableViewCell
    
    @property (nonatomic, retain) FlurryAdNative* ad;
    
    @end
 
    @implementation AdStreamCell
 
    - (void) setupAdCellForNativeAd:(FlurryAdNative*) nativeAd
    {
        [self.ad removeTrackingView];
        self.ad = nativeAd;
        self.ad.trackingView = self;
    }
 
    @endcode
 *
 *  @return View tracked by this ad object or nil if a tracking view has not been set on this object.
 *
 */
@property (nonatomic, retain) UIView *trackingView;

/*!
 *  @brief This property should be set to the view controller that needs to be used
 *  to present a full screen when the ad is clicked. Typically this will the topmost
 *  content view controller.
 *
 *
 *  @since 6.0.0
 *
 *  @see FlurryAdNativeAsset for details on the assets including asset names.\n
 *
 *  @code
 
    FlurryAdNative* nativeAd = [[FlurryAdNative alloc] initWithSpace:adSpace];
    nativeAd.adDelegate = self;
    nativeAd.viewControllerForPresentation = self;
    [nativeAd fetchAd];
 
 *  @endcode
 *
 *  @return UIViewcontroller used for presentation of a full screen or nil 
    if a presenting view controller has not been set
 *
 */
@property (nonatomic, retain) UIViewController* viewControllerForPresentation;


/*!
 *  @brief This property should be used for ad targeting based on parameters such as
 *  location, targeting kewords, age and gender
 *
 *
 *  @since 6.0.0
 *
 *  @see FlurryAdTargeting for details on the assets including asset names.\n
 *
 *  @return The Ad Targeting object that was orignally set or nil if never set.
 *
 */
@property (nonatomic, retain) FlurryAdTargeting *targeting;


/*!
 *  @brief Initialize the native ad object
 *  @since 6.0.0
 *
 *  This method initializes the ad object and gets it ready to fetch and serve a native ad.
 *
 *  @code
    FlurryAdNative* nativeAd = [[FlurryAdNative alloc] initWithSpace:@"STREAM_ADS"];
    @endcode
 *
 *  @param space represents the placement of the ad in your app. Typically all native ads that are
 *  presented within a single view controller will have the same ad space.
 *  For example, a carousel or a stream table view may have the following spaces
 *  @c "CAROUSEL_ADS" and @c "STREAM_ADS".
 *
 *
 */
- (id) initWithSpace:(NSString *)space;

/*!
 *  @brief Fetch an ad for this ad object
 *  @since 6.0.0
 *
 *
 *  @note The ad will be fetched using the ad space that was passed into initializer routines.\n
 *  This method must be called sometime after Flurry#startSession:
 *
 *  @see #ready: for details on verifying is an ad is ready to be displayed. \n
 *  FlurryAdNativeDelegate#adNativeDidFetchAd: for details on the notification of ads being received.\n
 *  FlurryAdNativeDelegate#adNative:adError:errorDescription: for details on notification of failure to receive ads from this request.\n
 *
 *  @code
    -(void) loadAds:(NSUInteger) count
    {
        NSString* adSpace = @"STREAM_ADS";
        for (int ix = 0; ix < count; ix++)
        {
            FlurryAdNative* nativeAd = [[FlurryAdNative alloc] initWithSpace:adSpace];
            nativeAd.adDelegate = self;
            nativeAd.viewControllerForPresentation = self;
            [nativeAd fetchAd];
            [self.nativeAds addObject:nativeAd];
        }
    }
    @endcode
 *
 */
- (void) fetchAd;

/*!
 *  @brief List of assets that match the specified asset type
 *
 *  This property can be used to retrieve a subset of the assets based on the asset view type.
 *
 *  @since 6.0.0
 *
 *  @see FlurryAdNativeAsset#kAssetType for the list of available asset types.\n
 *
 *  @code
 
    - (void) fetchNativeAd
    {
       FlurryAdNative* nativeAd = [[FlurryAdNative alloc] initWithSpace:adSpace];
       nativeAd.adDelegate = self;
       nativeAd.viewControllerForPresentation = self;
      [nativeAd fetchAd];
    }
 
    - (void) adNativeDidFetchAd:(FlurryAdNative*) nativeAd
    {
        NSArray* imageAssets = [nativeAd assetListForType:ASSET_TYPE_IMAGE]
       // user imageAssets in your app
    }
 
 *  @endcode
 *
 *  @return Array of assets for the specified asset type
 *
 */
- (NSArray*) assetListForType:(kAssetType)type;

/*!
 *  @brief Removes the tracking view associated with the ad object
 *
 *  Set this property prior to the reuse of a UIView to ensure that the view is not tracked by more than one ad object.
 *
 *  @note It is very important to set #trackingView to nil or call #removeTrackingView before the UIView cell associated with this ad is reused.
 *
 *  @since 6.0.0
 *
 *  @see #trackingView
 *
 *  @code
 
    @interface AdStreamCell : UITableViewCell

    @property (nonatomic, retain) FlurryAdNative* ad;

    @end

    @implementation AdStreamCell

    - (void) setupAdCellForNativeAd:(FlurryAdNative*) nativeAd
    {
        [self.ad removeTrackingView];
        self.ad = nativeAd;
        self.ad.trackingView = self;
    }
 
    @endcode
 *
 *
 */
- (void) removeTrackingView;

@end