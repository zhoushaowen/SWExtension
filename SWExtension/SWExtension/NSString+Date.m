//
//  NSString+Date.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

+ (instancetype)sw_createStringWithDate:(NSDate *)date dateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    //解决时差问题，将NSDate转换成北京时间
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    return [formatter stringFromDate:date];
}

+ (instancetype)sw_createStringWithUnknownSecondString:(NSString *)unknownSecond dateFormat:(NSString *)format
{
    if(unknownSecond == nil) return @"";
    if([unknownSecond isKindOfClass:[NSNumber class]]){
        unknownSecond = [NSString stringWithFormat:@"%@",unknownSecond];
    }
    if(unknownSecond.length < 1) return @"";
    NSTimeInterval second = [unknownSecond doubleValue];
    if(unknownSecond.length == 13){//毫秒
        second /= 1000;
    }else if (unknownSecond.length == 10){//秒
        //不处理
    }else if(unknownSecond.length > 13){
        second /= pow(10, unknownSecond.length - 13)*1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    return [self sw_createStringWithDate:date dateFormat:format];
}


@end
