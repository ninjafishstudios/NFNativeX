//
//  NFNativeX.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>

@interface NFNativeX : NSObject

+ (NFNativeX *)sharedInstance;


- (void)showInterstitial:(NSString *)label;

@end
