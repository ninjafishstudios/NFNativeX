//
//  NFNativeX.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "NFNativeX.h"
#import "NativeXSDK.h"



@interface NFNativeX() <NativeXSDKDelegate, NativeXAdViewDelegate>{
    NFNativeXShowImpressionCompletionHandler _showImpressionCompletionHandler;
}
@end

@implementation NFNativeX

+ (NFNativeX *)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}




- (void)showInterstitial:(NSString *)label{

    [self showInterstitial:label completionHandler:nil];
    
}

-(void)showInterstitial:(NSString *)label completionHandler:(NFNativeXShowImpressionCompletionHandler)completionHandler{
    _showImpressionCompletionHandler = completionHandler;
    
    
    [[NativeXSDK sharedInstance] setDelegate:self];
//    [[NativeXSDK sharedInstance] createSessionWithAppId:self.appId];
    //    [[NativeXSDK sharedInstance] fetchAdWithPlacement:kAdPlacementGameLaunch delegate:self];
    //    // Fetch the interstitial ad.
    [[NativeXSDK sharedInstance] showAdWithCustomPlacement:label];
}




#pragma mark <NativeXSDKDelegate>
// Called if the SDK initiates successfully
- (void)nativeXSDKDidCreateSession{

}

// Called if the SDK fails to initiate.
- (void)nativeXSDKDidFailToCreateSession:(NSError *)error{

}

- (void)nativeXAdView:(NativeXAdView *)adView didLoadWithPlacement:(NSString *)placement
{
    //Called when an ad has been loaded/cached and is ready to be shown
    
    // If you call displayAdView method here the SDK will show the ad as soon as it's ready
    [adView displayAdView];
}


/** called if no ad is available at this time
 *
 * @param adView        the NativeX adView that has NOT been loaded
 */
- (void)nativeXAdViewNoAdContent:(NativeXAdView *)adView{
    
    NSLog(@"native x ad view no ad content");
    
    if(_showImpressionCompletionHandler){
        _showImpressionCompletionHandler(NO);
        _showImpressionCompletionHandler = nil;
    }
    
    
}

/** Called when error loading an ad (was the SDK initialized correctly?)
 *
 * @param adView        the NativeX adView that has NOT been loaded because of an error
 * @param error         reason why ad failed to load
 */
- (void)nativeXAdView:(NativeXAdView *)adView didFailWithError:(NSError *)error{
    NSLog(@"native x ad view did fail with error");
    
    if(_showImpressionCompletionHandler){
        _showImpressionCompletionHandler(NO);
        _showImpressionCompletionHandler = nil;
    }
    
}


/** called after an ad has been displayed on screen
 *
 * @param adView        the NativeX adView that displayed
 */
- (void)nativeXAdViewDidDisplay:(NativeXAdView *)adView{
    NSLog(@"ad view did display");
    if(_showImpressionCompletionHandler){
        _showImpressionCompletionHandler(YES);
        _showImpressionCompletionHandler = nil;
    }

}


/** Called when ad content has expired for specific adView
 *
 * @param adView        the NativeX adView that has expired
 */
- (void)nativeXAdViewDidExpire:(NativeXAdView *)adView{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadInterstitial:)]){
        [self.delegate didFailToLoadInterstitial:nil];
    }
    
}

/** called right before an ad will be displayed
 *
 * @param adView        the NativeX adView that will be displayed
 */
- (void)nativeXAdViewWillDisplay:(NativeXAdView *)adView{
    
}


/** called right before an inline ad will change size (non-modal)
 *
 * @param adView        the NativeX adView that will change size
 * @param newFrame      the new size and position of ad
 */
- (void)nativeXAdView:(NativeXAdView *)adView willResizeToFrame:(CGRect)newFrame{
    
}

/** called after inline ad has resized (non-modal)
 *
 * @param adView        the NativeX adView that changed size
 * @param newFrame      the new size and position of ad
 */
- (void)nativeXAdView:(NativeXAdView *)adView didResizeToFrame:(CGRect)newFrame{
    
}

/** called right before an inline ad will expand to take up full screen (modal)
 *
 * @param adView        the NativeX adView that will expand
 */
- (void)nativeXAdViewWillExpand:(NativeXAdView *)adView{
    
}

/** called after an inline ad has expanded to take up full screen (modal)
 *
 * @param adView        the NativeX adView that expanded
 */
- (void)nativeXAdViewDidExpand:(NativeXAdView *)adView{
    
}

/** called right before inline ad will collapse back to default size
 *
 * @param adView        the NativeX adView that will collapse
 */
- (void)nativeXAdViewWillCollapse:(NativeXAdView *)adView{
    
}

/** called after inline ad collapses back to default size
 *
 * @param adView        the NativeX adView that collapsed
 */
- (void)nativeXAdViewDidCollapse:(NativeXAdView *)adView{
    
}

/** called right before an ad will be dismissed (removed from screen)
 *
 * @param adView        the NativeX adView that will be dismissed
 */
- (void)nativeXAdViewWillDismiss:(NativeXAdView *)adView{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didDismissInterstitial:)]){
        [self.delegate didDismissInterstitial:nil];
    }
}

/** called after an ad has been dismissed (removed from screen)
 *
 * @param adView        the NativeX adView that was dismissed
 */
- (void)nativeXAdViewDidDismiss:(NativeXAdView *)adView{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didDismissInterstitial:)]){
        [self.delegate didDismissInterstitial:nil];
    }
    
}





@end
