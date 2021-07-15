//
//  QNResidueDateView.h
//  MillenniumGourd
//
//  Created by bavaria on 2021/7/15.
//  Copyright © 2021 Qian Nian Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 根据日记差只显示
typedef enum : NSUInteger {
    // 显示剩余天数、小时数、分支数、秒数
    QNResidueDateViewTypeAll = 0,
    // 只显示 小时数、分支数、秒数
    QNResidueDateViewTypeHourMinuteSecond,
    QNResidueDateViewTypeMinuteSecond,
    QNResidueDateViewTypeSecond,
} QNResidueDateViewType;

@interface TLResidueDateView : UIView

-(void)setDay:(NSString *)day hour:(NSString *)hour minute:(NSString *)minute second:(NSString *)second;
/// 设置单位
-(void)setDayUnit:(NSString *)dayUnit hourUnit:(NSString *)hourUnit minuteUnit:(NSString *)minuteUnit secondUnit:(NSString *)secondUnit;

-(void)setDateFont:(UIFont *)dateFont sepLabelFont:(UIFont *)sepLabelFont;


@end

NS_ASSUME_NONNULL_END
