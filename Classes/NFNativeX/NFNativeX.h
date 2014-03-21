//
//  NFNativeX.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>

@interface NFNativeX : NSObject

typedef void (^ NFNativeXShowImpressionCompletionHandler)(BOOL installed);

@property (nonatomic, copy) NSString *appId;


+ (NFNativeX *)sharedInstance;
- (void)showInterstitial:(NSString *)label;
-(void)showInterstitial:(NSString *)label completionHandler:(NFNativeXShowImpressionCompletionHandler)completionHandler;


@end
