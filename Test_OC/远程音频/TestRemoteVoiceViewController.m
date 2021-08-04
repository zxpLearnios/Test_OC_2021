//
//  TestRemoteVoiceViewController.m
//  Test_OC
//
//  Created by bavaria on 2021/8/1.
//  音频播放

#import "TestRemoteVoiceViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import "TestVoiceManager.h"

@interface TestRemoteVoiceViewController ()
{
    
}

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, assign) double playTime;
@property (nonatomic, strong) id timeObserve;

@property (nonatomic, strong) TestVoiceManager *voiceManager;
@end

@implementation TestRemoteVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"播放" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
    btn.backgroundColor = [UIColor grayColor];
    
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"播放第170s" forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(btnAction1) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    btn1.backgroundColor = [UIColor grayColor];
    
    
    [self.view addSubview:btn];
    [self.view addSubview:btn1];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.height.mas_equalTo(100);
    }];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(100);
        make.top.equalTo(btn.mas_bottom).offset(50);
    }];
    
    // 锁屏音频
    TestVoiceManager *vm = [TestVoiceManager new];
    self.voiceManager = vm;
    [vm setScreenLockVoiceInfo];
    
    WEAK(weakSelf);
    vm.receiveRemoteVoiceControlBlock = ^(NSDictionary * _Nonnull userInfo) {
        NSInteger subtype = ((NSNumber *)userInfo[kvoiceRemoteControlTypekey]).intValue;
        [weakSelf handleVoiceRemoteControl:subtype];
    };
    // 音频控制 通知, 这里收不到，所有在TestVoiceManager收
//    [self addVoiceRemotNoti];
}


//-(void)addVoiceRemotNoti {
//    [knotificationCenter addObserver:self selector:@selector(handleVoiceRemoteControl:) name:kvoiceRemoteControlNotikey object:nil];
//}
//
//-(void)handleVoiceRemoteControl:(NSNotification *)noti {
//    NSDictionary *dic = noti.userInfo;
//    //
//}
//

#pragma mark 锁屏等控制音频时
-(void)handleVoiceRemoteControl:(NSInteger)subtype{
    // iphone6,  subType 底顶部弹出 100: 下一步为播放,  101: 下一步为暂停
    if (subtype == 100) {
        [self.avPlayer play];
    } else if (subtype == 101) {
        [self.avPlayer pause];
    }
}

#pragma mark 播放按钮
-(void)btnAction {
    [self setupVoicePlayer];
}

-(void)btnAction1 {
    if (self.avPlayer.currentItem.status == AVPlayerItemStatusReadyToPlay) { // 准备好播放、正在播放
        [self.avPlayer pause];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 从第几秒开始播放
        int32_t timeScale = self.avPlayer.currentItem.asset.duration.timescale;
        CMTime shouldPlayime = CMTimeMakeWithSeconds(170, timeScale);
        [self.avPlayer seekToTime:shouldPlayime toleranceBefore:CMTimeMake(1, 1000)
                                         toleranceAfter:CMTimeMake(1, 1000)];
        [self.avPlayer play];
    });
}

#pragma mark 播放完毕
-(void)playbackFinished:(NSNotification *)noti {
    NSLog(@"播放完毕");
}

#pragma mark 音频播放
-(void)setupVoicePlayer {
    // @"http://music.163.com/song/media/outer/url?id=28387594.mp3";
    // 童年 @"http://music.163.com/song/media/outer/url?id=109530.mp3";
    // 公司  https://qnshop.oss-cn-beijing.aliyuncs.com/uploads/20210720/685997280b08022788bcc335b61269d1.m4a
    
    NSString *voiceStr = @"http://music.163.com/song/media/outer/url?id=109530.mp3";
    NSURL *vUrl = [NSURL URLWithString:voiceStr];
    AVAsset *avAsset = [AVAsset assetWithURL:vUrl];
    if (!avAsset.isPlayable) {
        NSLog(@"无法播放此音频");
        return;
    }
    
    AVPlayerItem *avItem = [[AVPlayerItem alloc]initWithAsset:avAsset];
    
    // 0. 监听改播放器状态
    [avItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 0.1 数据缓冲状态
    [avItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    
    if (!self.avPlayer) {
        AVPlayer *avPlayer = [AVPlayer new];
        self.avPlayer = avPlayer;
    }
    
    // 1.
    __weak typeof(self) weakSelf = self;
    // 监听播放进度
    [self removeTimerObserver];
    
    self.timeObserve = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds(avItem.duration);
        weakSelf.playTime = current;
        if (current == total) {
            // 播放完毕移除观察者
            [avItem removeObserver:weakSelf forKeyPath:@"status"];
            [avItem removeObserver:weakSelf forKeyPath:@"loadedTimeRanges"];
        }
            
        [weakSelf.voiceManager setHavePlaySeconds:(int)current];
        [weakSelf.voiceManager setTotalSeconds:(int)total];
        
        NSLog(@"播放进度: %f", total);
    }];
    
    // 2. 移除是一个item播放完毕的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 3. 监听当前item播放完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:avItem];
    
    // 使用最新的item
    [self.avPlayer replaceCurrentItemWithPlayerItem:avItem];
    [self.avPlayer play];
}


#pragma mark 监听状态改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSString *str;
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.avPlayer.status) {
            case AVPlayerStatusUnknown:
                str = @"未知状态，此时不能播放";
                break;
            case AVPlayerStatusReadyToPlay:
                str = @"准备完毕，可以播放";
                break;
            case AVPlayerStatusFailed:
                str = @"加载失败，网络或者服务器出现问题";
                break;
            default:
                break;
        }
        NSLog(@"监听状态： %@", str);
    } else {
        if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            if ([object isKindOfClass:[AVPlayerItem class]]) { // playItem
                AVPlayerItem *songItem = object;
                
                NSArray *array = songItem.loadedTimeRanges;
                CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
                // 本次缓冲的时间范围
                NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration); //缓冲总长度
                NSLog(@"共缓冲%.2f", totalBuffer);
            }
        }
        
    }
    
    
}


-(void)removeTimerObserver {
    if (self.timeObserve) {
        self.playTime = 0;
        [self.avPlayer removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
}

- (void)dealloc
{
    [self removeTimerObserver];
}

@end
