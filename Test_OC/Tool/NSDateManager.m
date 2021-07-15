//
//  NSDateManager.m
//  Test_OC
//
//  Created by bavaria on 2021/7/15.
//

#import "NSDateManager.h"

@implementation NSDateManager



#pragma mark 1. [day, hour, minute, second], 都是前缀不带0的. 获取两个日期的时差
+(NSArray <NSNumber *> *)getDayHourStringWithBeginDateString:(NSString *)beginDateString endDateString:(NSString *)endDateString {
    NSDate *beginDate = [self getDateFromDateString:beginDateString];
    NSDate *endDate = [self getDateFromDateString:endDateString];
    
    int daySecond = 24 * 60 * 60;
    int hourSecond = 60 * 60;
    int minuteSecond = 60;
    
    int dayNumber = 0;
    int hourNumber = 0;
    int minuteNumber = 0;
    int secondNumber = 0;
    
    if (beginDate == nil && endDate == nil) {
        return @[[NSNumber numberWithInt:0],
                 [NSNumber numberWithInt:0],
                 [NSNumber numberWithInt:0],
                 [NSNumber numberWithInt:0]];
    }
    
    // 时间差
    int timeInterval = [endDate timeIntervalSinceDate:beginDate];
    
    if (timeInterval < daySecond) { // 0天
        dayNumber = 0;
        if (timeInterval >= hourSecond) {  // >1小时
            hourNumber = timeInterval / hourSecond;
            int tmpMinute = timeInterval % hourSecond;
            
            if (tmpMinute >= minuteSecond) { // 超过1分
                minuteNumber = tmpMinute / minuteSecond;
                secondNumber = tmpMinute % minuteSecond;
            } else {  // 不足1分钟
                minuteNumber = 0;
                secondNumber = tmpMinute;
            }
        } else { // 不足1小时
            hourNumber = 0;
            if (timeInterval >= minuteSecond) { // 超过1分钟
                minuteNumber = timeInterval / minuteSecond;
                secondNumber = timeInterval % minuteSecond;
            } else { // 不足1分钟
                minuteNumber = 0;
                secondNumber = timeInterval;
            }
            
        }
    } else { // >=1天
        dayNumber = timeInterval / daySecond;
        
        int tmpMainInt = timeInterval % daySecond;
        if (tmpMainInt >= hourSecond) {  // >1小时
            hourNumber = tmpMainInt / hourSecond;
            int tmpMinute = tmpMainInt % hourSecond;
            
            if (tmpMinute >= minuteSecond) { // 超过1分
                minuteNumber = tmpMinute / minuteSecond;
                secondNumber = tmpMinute % minuteSecond;
            } else {  // 不足1分钟
                minuteNumber = 0;
                secondNumber = tmpMinute;
            }
        } else { // 不足1小时
            hourNumber = 0;
            if (tmpMainInt >= minuteSecond) { // 超过1分钟
                minuteNumber = tmpMainInt / minuteSecond;
                secondNumber = tmpMainInt % minuteSecond;
            } else { // 不足1分钟
                minuteNumber = 0;
                secondNumber = tmpMainInt;
            }
            
        }
    }
    
        return @[[NSNumber numberWithInt:dayNumber],
                 [NSNumber numberWithInt:hourNumber],
                 [NSNumber numberWithInt:minuteNumber],
                 [NSNumber numberWithInt:secondNumber]];
}

#pragma mark 2. 传入毫秒数得到 [day, hour, minute, second], 都是前缀不带0的
+(NSArray <NSNumber *> *)getDayHourStringWithTimeInterval:(int)timeIntervalParam {
    int daySecond = 24 * 60 * 60;
    int hourSecond = 60 * 60;
    int minuteSecond = 60;
    
    int dayNumber = 0;
    int hourNumber = 0;
    int minuteNumber = 0;
    int secondNumber = 0;
    
    if (timeIntervalParam <= 0) {
        return @[[NSNumber numberWithInt:0],
                 [NSNumber numberWithInt:0],
                 [NSNumber numberWithInt:0],
                 [NSNumber numberWithInt:0]];
    }
    
    // 时间差 秒数
    int timeInterval = timeIntervalParam / 1000;
    
    if (timeInterval < daySecond) { // 0天
        dayNumber = 0;
        if (timeInterval >= hourSecond) {  // >1小时
            hourNumber = timeInterval / hourSecond;
            int tmpMinute = timeInterval % hourSecond;
            
            if (tmpMinute >= minuteSecond) { // 超过1分
                minuteNumber = tmpMinute / minuteSecond;
                secondNumber = tmpMinute % minuteSecond;
            } else {  // 不足1分钟
                minuteNumber = 0;
                secondNumber = tmpMinute;
            }
        } else { // 不足1小时
            hourNumber = 0;
            if (timeInterval >= minuteSecond) { // 超过1分钟
                minuteNumber = timeInterval / minuteSecond;
                secondNumber = timeInterval % minuteSecond;
            } else { // 不足1分钟
                minuteNumber = 0;
                secondNumber = timeInterval;
            }
            
        }
    } else { // >=1天
        dayNumber = timeInterval / daySecond;
        
        int tmpMainInt = timeInterval % daySecond;
        if (tmpMainInt >= hourSecond) {  // >1小时
            hourNumber = tmpMainInt / hourSecond;
            int tmpMinute = tmpMainInt % hourSecond;
            
            if (tmpMinute >= minuteSecond) { // 超过1分
                minuteNumber = tmpMinute / minuteSecond;
                secondNumber = tmpMinute % minuteSecond;
            } else {  // 不足1分钟
                minuteNumber = 0;
                secondNumber = tmpMinute;
            }
        } else { // 不足1小时
            hourNumber = 0;
            if (tmpMainInt >= minuteSecond) { // 超过1分钟
                minuteNumber = tmpMainInt / minuteSecond;
                secondNumber = tmpMainInt % minuteSecond;
            } else { // 不足1分钟
                minuteNumber = 0;
                secondNumber = tmpMainInt;
            }
            
        }
    }
    
        return @[[NSNumber numberWithInt:dayNumber],
                 [NSNumber numberWithInt:hourNumber],
                 [NSNumber numberWithInt:minuteNumber],
                 [NSNumber numberWithInt:secondNumber]];
}



+(NSDate *)getDateFromDateString:(NSString *)dateStr {
    if (dateStr.length == 0) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}


@end
