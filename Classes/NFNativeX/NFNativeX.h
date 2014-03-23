//
//  NFNativeX.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "NFAdDisplayer.h"

@interface NFNativeX : NSObject

typedef void (^ NFNativeXShowImpressionCompletionHandler)(BOOL installed);

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, unsafe_unretained) id<NFAdDisplayerDelegate> delegate;

+ (NFNativeX *)sharedInstance;
- (void)showInterstitial:(NSString *)label;
-(void)showInterstitial:(NSString *)label completionHandler:(NFNativeXShowImpressionCompletionHandler)completionHandler;


@end
