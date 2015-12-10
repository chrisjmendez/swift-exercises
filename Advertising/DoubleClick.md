DoubleClick for Publishers (DFP)
=

What
-
Google DoubleClick for Publishers (DFP) makes it easy to integrate AD revenue technology on a smaller, business scale.  Yes, sometimes you don't need to scale. 

Why
-
DFP allows you, the media publisher, to sell AD inventory (aka real-estate) to advertisers. Using DFP, you can also sell HouseAds and targeted Ads. 

How
-

####Step 1: Signup for AdSense and DoubleClick for Publishers

1. [Sign up for Google AdSense](https://www.google.com/adsense/start/)
- [Sign up for Google DoubleClick for Publishers](https://www.google.com/dfp/signin)

####Step 2: Creating an In-House AD for Mobile

The process could be simpler but here's the gist. You first need to create the banner AD (called 'Creatives'). Once you create the creatives, you then need to create a container for the creative (called 'Ad Units'). Once you've made a "Creative" and an "AD Unit", then you can focus on the "Placement" of the AD unit. The next step is to publish the ads on the website.  Since your client is paying to show its presence on your website, you'll need to create an "Order". An order helps sell your inventory to advertisers. A line item holds the characteristics of the AD you'll be serving. They are designed to help the advertiser feel like they have customization and control. The final step is to publish the AD tags (or unique URL) required to paste into your website.

The order: 

1. **Creatives** - [Video](https://support.google.com/dfp_premium/answer/1209767?hl=en)
-  **AD Units**
-  **Placement**
-  **Orders** - [Video](https://support.google.com/dfp_sb/answer/82236?hl=en)
-  **Line Items** - They are traits such as the size of the AD, what AD units will be targeted, how long the ad will serve those ad units, what the creative will be, where the AD should be served (geographically).  
-  **AD Tag**

-


####Step 3a: Install DoubleClick SDK using CocoaPods
-
1. Make sure you have [CocoaPoads installed](https://guides.cocoapods.org/using/getting-started.html)
- Configure [CocoaPods Podfile for DFP](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/quick-start)
- Run ```pod install``` or ```pod update```
- Start working with the CocoaPod-ready project file ```nameofproject.xcworkspace```


####Step 3b: Manually install DoubleClick SDK
-
1. [Quick Start using CocoaPosds](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/quick-start#manually_using_the_sdk_download)

####Step 4: iOS 9 Changes
-
- [iOS 9 Considerations](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/ios9)

####Step 5: Look into /ADMob for a mediation network.

Glossary
- 
- **Smart Banner AD**: This a banner ad that is smart enough to resize itself for portrait or landscape.
- **Interstitial**: This is how you can occupy the entire screen on a mobile phone.
- **Mediation**: A mediation network 



Resources
-

####!!!WATCH THIS FIRST!!!
- [CONFIGURING DFP FOR IN-APP MOBILE](https://support.google.com/dfp_premium/answer/6238696?rd=1)


####Basic Tutorial
- [Tutorial: How to create your first AD](http://www.labnol.org/internet/google-dfp-tutorial/14099/)


####Making a "Creative"
- [List of In-App Creative Formats](http://snag.gy/m1D3h.jpg)
- [Create a mobile creative](https://support.google.com/dfp_premium/answer/1209767?hl=en)
- [Create an AD unit for Mobile (aka Smart Banner AD](https://support.google.com/dfp_sb/answer/82275#create)


####Creative Dimensions
- Text and image creatives: [Size 1](http://snag.gy/bFsHh.jpg), [Size 2](http://snag.gy/XA91f.jpg), [IAB Standard](http://snag.gy/zorY4.jpg)
- Mobile creatives: [Portrait](http://snag.gy/TgzKh.jpg)
- Tablet creatives: [Portrait](http://snag.gy/8aHLW.jpg), [Landscape](http://snag.gy/2mMb4.jpg)

####Google Publisher University
- [Publisher University](g.co/PublisherU)
- [School of DFP](https://publisheruniversity.withgoogle.com/dfp/en/school_overview/intro.html)


####Using DoubleClick as a Mediation Network
- [Main page](https://developers.google.com/ads/#apps)

####Stackoverflow Answers

- [Using ADMob + DFP solely for House Ads](http://stackoverflow.com/questions/11180588/using-admob-solely-for-house-ads)
- [Offers in-house ads](http://www.google.com/doubleclick/publishers/small-business/)
- [You can serve DoubleClick ads through AdMob](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/quick-start)


####iOS Resources
- [Banner Ads](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/banner)
- [Interstitial Ad](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/interstitial)
- [Ad Targeting](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/targeting)
- [Native Ads](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/native)
- [Mobile Rich Media Ads](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/mraid)


