//
//  QNVoiceManager.h
//  MillenniumGourd
//
//  Created by bavaria on 2021/8/2.
//  Copyright © 2021 Qian Nian Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestVoiceManager : NSObject

+(instancetype)shared;

#pragma mark 后台播放音频
-(void)openPlayVoiceInBackground;

@end

NS_ASSUME_NONNULL_END
