//
//  NSString+Valid.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/25.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)

/**
 判断是否是手机号码

 @param number 号码字符串
 @return YES是手机号码,NO不是
 */
+ (BOOL)isValidPhoneNumber:(NSString *)number;

@end
