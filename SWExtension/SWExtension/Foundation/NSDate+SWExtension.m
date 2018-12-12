//
//  NSDate+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "NSDate+SWExtension.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation NSDate (SWExtension)

+ (instancetype)sw_createDateWithDateString:(NSString *)dateString dateFormat:(NSString *)formatterString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置为公历日历
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    formatter.dateFormat = formatterString;
    formatter.timeZone = [self sw_localTimeZone];
    return [formatter dateFromString:dateString];
}

+ (NSTimeZone *)sw_localTimeZone {
    //设置转换后的目标日期时区
    NSTimeZone *toTimeZone = [NSTimeZone localTimeZone];
    //转换后源日期与世界标准时间的偏移量
    NSInteger toGMTOffset = [toTimeZone secondsFromGMTForDate:[NSDate date]];
    return [NSTimeZone timeZoneForSecondsFromGMT:toGMTOffset];
}

@end
