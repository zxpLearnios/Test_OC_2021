//
//  AppDelegate.m
//  Test_OC
//
//  Created by bavaria on 2021/1/25.
//

#import "AppDelegate.h"
#import "NSDateManager.h"
#import "TestVoiceManager.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *ary =[NSDateManager getDayHourStringWithTimeInterval: 60 * 1000];
    // 远程事件
    [UIApplication.sharedApplication beginReceivingRemoteControlEvents];
    
    [TestVoiceManager.shared openPlayVoiceInBackground];
    
    return YES;
}

#pragma mark 处理远程事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event {
    
    if (event.type == UIEventTypeRemoteControl) {
        /** > 100的才有用
         typedef NS_ENUM(NSInteger, UIEventSubtype) {
             // available in iPhone OS 3.0
             UIEventSubtypeNone                              = 0,
             // for UIEventTypeMotion, available in iPhone OS 3.0
             UIEventSubtypeMotionShake                       = 1,
             //这之后的是我们需要关注的枚举信息
             // for UIEventTypeRemoteControl, available in iOS 4.0
             //点击播放按钮或者耳机线控中间那个按钮
             UIEventSubtypeRemoteControlPlay                 = 100,
             //点击暂停按钮
             UIEventSubtypeRemoteControlPause                = 101,
             //点击停止按钮
             UIEventSubtypeRemoteControlStop                 = 102,
             //点击播放与暂停开关按钮(iphone抽屉中使用这个)
             UIEventSubtypeRemoteControlTogglePlayPause      = 103,
             //点击下一曲按钮或者耳机中间按钮两下
             UIEventSubtypeRemoteControlNextTrack            = 104,
             //点击上一曲按钮或者耳机中间按钮三下
             UIEventSubtypeRemoteControlPreviousTrack        = 105,
             //快退开始 点击耳机中间按钮三下不放开
             UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
             //快退结束 耳机快退控制松开后
             UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
             //开始快进 耳机中间按钮两下不放开
             UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
             //快进结束 耳机快进操作松开后
             UIEventSubtypeRemoteControlEndSeekingForward    = 109,
         };
         */
//        NSLog(@"%ld",event.subtype);
        
        NSInteger subType = event.subtype;
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        mdic[kvoiceRemoteControlTypekey] = @(subType);
        // iphone6,  subType 底顶部弹出 100: 播放,  101:暂停
        //
        [knotificationCenter postNotificationName:kvoiceRemoteControlNotikey object:nil userInfo:mdic];
        NSLog(@"远程控制音频了 : %ld", subType);
    }
}



@end
