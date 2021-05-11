//
//  CLTestSharedViewManager.h
//  Test_OC
//
//  Created by bavaria on 2021/1/26.
//

#import <Foundation/Foundation.h>
#import "CLTestSharedView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLTestSharedViewManager : NSObject
@property (nonatomic, strong) CLTestSharedView *view;

+(instancetype)shared;

@end

NS_ASSUME_NONNULL_END
