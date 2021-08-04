//
//  QNVoiceManager.m
//  MillenniumGourd
//
//  Created by bavaria on 2021/8/2.
//  Copyright © 2021 Qian Nian Tech. All rights reserved.
//

#import "TestVoiceManager.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface TestVoiceManager ()
/// 存放音频的信息
@property (nonatomic, strong) NSMutableDictionary *voiceInfoDic;
@end

@implementation TestVoiceManager

+(instancetype)shared {
    static TestVoiceManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TestVoiceManager alloc] init];
    });
    return obj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.voiceInfoDic = [NSMutableDictionary dictionary];
    [self addVoiceRemotNoti];
}

-(void)addVoiceRemotNoti {
    [knotificationCenter addObserver:self selector:@selector(handleVoiceRemoteControl:) name:kvoiceRemoteControlNotikey object:nil];
}

-(void)handleVoiceRemoteControl:(NSNotification *)noti {
    NSDictionary *dic = noti.userInfo;
    if (self.receiveRemoteVoiceControlBlock) {
        self.receiveRemoteVoiceControlBlock(dic);
    }
}


#pragma mark 后台播放音频
-(void)openPlayVoiceInBackground {
    AVAudioSession *session = AVAudioSession.sharedInstance;
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}


#pragma mark  3. 设置总时长
-(void)setTotalSeconds:(int)seconds {
    NSNumber *oldTotalTimelength = self.voiceInfoDic[MPMediaItemPropertyPlaybackDuration];
    if (oldTotalTimelength.intValue != seconds) {
        // 设置歌曲时长
        /**
         MPMediaItemPropertyPlaybackDuration: 剩余总时长
         MPNowPlayingInfoPropertyPlaybackRate: 播放速度
         */
        [self.voiceInfoDic setObject:[NSNumber numberWithInt:seconds] forKey:MPMediaItemPropertyPlaybackDuration];
        // 更新锁屏音频信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:self.voiceInfoDic];
    }
}

#pragma mark 3.1 设置已经播放的时长
-(void)setHavePlaySeconds:(int)seconds {
    NSNumber *havePlayTimelength = self.voiceInfoDic[MPNowPlayingInfoPropertyElapsedPlaybackTime];
    if (havePlayTimelength.intValue != seconds) {
        [self.voiceInfoDic setObject:[NSNumber numberWithInt:seconds] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        // 更新锁屏音频信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:self.voiceInfoDic];
    }
    
}

/// 3.2 设置所有信息
-(void)setAllScreenLockVoiceInfo:(NSDictionary *)dic {
    for (NSString *key in dic.allKeys) {
        self.voiceInfoDic[key] = dic[key];
    }
    // 更新锁屏音频信息
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:self.voiceInfoDic];
}

#pragma mark 设置锁屏音频信息
-(void)setScreenLockVoiceInfo {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 设置歌曲题目
    [dict setObject:@"题目" forKey:MPMediaItemPropertyTitle];
    // 设置歌手名
    [dict setObject:@"歌手" forKey:MPMediaItemPropertyArtist];
    // 设置专辑名
    [dict setObject:@"专辑" forKey:MPMediaItemPropertyAlbumTitle];
    // 设置显示的图片
    UIImage *lockVoiceImage = [UIImage imageNamed:@"global_screenLock_icon"];
    MPMediaItemArtwork *mItemArtwork = [[MPMediaItemArtwork alloc]initWithBoundsSize:CGSizeMake(200, 100) requestHandler:^UIImage * _Nonnull(CGSize size) {
        return lockVoiceImage;
    }];
    [dict setObject:mItemArtwork forKey:MPMediaItemPropertyArtwork];
    // 更新锁屏音频信息
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
}

@end
