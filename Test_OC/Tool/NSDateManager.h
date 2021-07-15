//
//  NSDateManager.h
//  Test_OC
//
//  Created by bavaria on 2021/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateManager : NSObject



#pragma mark---1. [day, hour, minute, second], 都是前缀不带0的. 获取两个日期的时差
+(NSArray <NSNumber *> *)getDayHourStringWithBeginDateString:(NSString *)beginDateString endDateString:(NSString *)endDateString;

#pragma mark 2. 传入毫秒数得到 [day, hour, minute, second], 都是前缀不带0的
+(NSArray <NSNumber *> *)getDayHourStringWithTimeInterval:(int)timeIntervalParam;

#pragma mark
+(NSDate *)getDateFromDateString:(NSString *)dateStr;


@end

NS_ASSUME_NONNULL_END
