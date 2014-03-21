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



@end
