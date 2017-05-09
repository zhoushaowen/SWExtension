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

+ (instancetype)sw_createDateWithDateString:(NSString *)dateString dateFormate:(NSString *)formatterString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterString;
    return [formatter dateFromString:formatterString];
}

@end
