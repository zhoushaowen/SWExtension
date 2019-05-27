//
//  NSDate+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SWExtension)

/**
 创建日期

 @param dateString 日期字符串
 @param formatterString 日期格式
 @return 创建的日期
 */
+ (instancetype)sw_createDateWithDateString:(NSString *)dateString dateFormat:(NSString *)formatterString;

@end
