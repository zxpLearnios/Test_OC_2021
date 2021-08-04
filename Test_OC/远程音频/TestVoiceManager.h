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

@property (nonatomic, copy) void (^receiveRemoteVoiceControlBlock)(NSDictionary *userInfo);

+(instancetype)shared;

#pragma mark 后台播放音频
-(void)openPlayVoiceInBackground;
#pragma mark 设置锁屏音频信息
-(void)setScreenLockVoiceInfo;

/// 3. 只设置总时长, 只设置这个锁屏的就会自动显示各个时长了
-(void)setTotalSeconds:(int)seconds;
/// 3.1只设置已经播放的时长， 暂时无用
-(void)setHavePlaySeconds:(int)seconds;
/// 3.2 设置所有信息
-(void)setAllScreenLockVoiceInfo:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
