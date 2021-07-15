//
//  TestActivityResidueTimeViewController.m
//  Test_OC
//
//  Created by bavaria on 2021/7/15.
//  活动剩余时间计算及倒计时显示

#import "TestActivityResidueTimeViewController.h"
#import <Masonry/Masonry.h>
#import "NSDateManager.h"
#import "TLResidueDateView.h"


@interface TestActivityResidueTimeViewController ()

@property (nonatomic, strong) TLResidueDateView *dateView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isStart;

//------------- 记录活动总共还剩几天几时几分几秒 --------------
// 活动剩余总秒数
@property (nonatomic, assign) int activitySecond;
@property (nonatomic, assign) int day;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int second;

// 定时器走的秒数
@property (nonatomic, assign) int timerSecond;
@end

@implementation TestActivityResidueTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViewForSelf];
    [self caculateActivityTime];
}

-(void)addSubViewForSelf {
    TLResidueDateView *dateView = [TLResidueDateView new];
    UIButton *btn = [UIButton new];
    self.dateView = dateView;
    
    [self.view addSubview:dateView];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.height.mas_equalTo(100);
        make.bottom.equalTo(dateView.mas_top).offset(-100);
    }];
    
}

-(void)btnAction {
    self.isStart = !self.isStart;
    (self.isStart) ? [self beginTimer] : [self stopTimer];
}

-(void)caculateActivityTime {
    // 方式1
    NSString *beginDateStr = @"2021-03-01 00:00:00";
    NSString *endDateStr = @"2021-03-01 01:02:06";
    
    NSArray *dateCompentAry = [NSDateManager getDayHourStringWithBeginDateString:beginDateStr endDateString:endDateStr];

    int day = ((NSNumber *)dateCompentAry[0]).intValue;
    int hour = ((NSNumber *)dateCompentAry[1]).intValue;
    int minute = ((NSNumber *)dateCompentAry[2]).intValue;
    int second = ((NSNumber *)dateCompentAry[3]).intValue;

    self.day = day;
    self.hour = hour;
    self.minute = minute;
    self.second = second;

    // 总的剩余时间转出 总秒数
    NSDate *beginDate = [NSDateManager getDateFromDateString:beginDateStr];
    NSDate *endDate = [NSDateManager getDateFromDateString:endDateStr];
    int totalTimeInterval = [endDate timeIntervalSinceDate:beginDate];
    self.activitySecond = totalTimeInterval;
}

//---------------------- 定时器 ------------------------

-(void)beginTimer  {
    __weak typeof(self) weakSelf = self;
    if (self.timer != nil) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [weakSelf timerAction];
        });
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)timerAction {
    self.timerSecond += 1;
    
    // 方式2  根据定时器走的总秒数 获取 天数时数分数秒数
    int sepc = self.activitySecond - self.timerSecond;
    NSArray *dateCompentAry = [NSDateManager getDayHourStringWithTimeInterval: sepc * 1000];
   
    // 设置
    int residueDay = ((NSNumber *)dateCompentAry[0]).intValue;
    int residueHour = ((NSNumber *)dateCompentAry[1]).intValue;
    int residueMinute = ((NSNumber *)dateCompentAry[2]).intValue;
    int residueSecond = ((NSNumber *)dateCompentAry[3]).intValue;
    
    NSString *residueDayStr = [NSString stringWithFormat:@"%02d", residueDay];
    NSString *residueHourStr = [NSString stringWithFormat:@"%02d", residueHour];
    NSString *residueMinuteStr = [NSString stringWithFormat:@"%02d", residueMinute];
    NSString *residueSecondStr = [NSString stringWithFormat:@"%02d", residueSecond];
//    NSString *str = [NSString stringWithFormat:@"当前剩余%d天-%d时-%d分-%d秒", residueDay, residueHour, residueMinute, residueSecond];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dateView setDay:residueDayStr hour:residueHourStr minute:residueMinuteStr second:residueSecondStr];
        [self.dateView setDayUnit:@"天" hourUnit:@"时" minuteUnit:@"分" secondUnit:@"秒"];
        [self.dateView setDateFont:[UIFont boldSystemFontOfSize:24] sepLabelFont:[UIFont boldSystemFontOfSize:15]];
    });
}

- (void)dealloc
{
    
}

@end
