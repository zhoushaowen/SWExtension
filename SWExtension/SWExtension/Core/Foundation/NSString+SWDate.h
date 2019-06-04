//
//  NSString+SWDate.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SWDate)

/**
 通过NSDate创建一个带格式的时间字符串，默认转换之后的时间是北京时间
 */
+ (instancetype)sw_createStringWithDate:(NSDate *)date dateFormat:(NSString *)format;

/**
 将毫秒或者秒字符串转换成指定格式的时间字符串

 @param unknownSecond 未知长度的时间长度字符串
 @param format 格式
 @return 转换之后的时间字符串
 */
+ (instancetype)sw_createStringWithUnknownSecondString:(NSString *)unknownSecond dateFormat:(NSString *)format;

@end
