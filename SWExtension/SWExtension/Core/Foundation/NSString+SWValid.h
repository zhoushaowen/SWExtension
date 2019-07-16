//
//  NSString+SWValid.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/25.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SWValid)

/**
 判断是否是手机号码

 @return YES是手机号码,NO不是
 */
//- (BOOL)isValidPhoneNumber;

///判断是否是邮箱账号
- (BOOL)sw_isEmailString;
///判断是否是身份证号码
- (BOOL)sw_isValidateIdentityCard;
///从身份证号码中解析出身份证字符串,e.g. 2019-07-12 支持18位和15位身份证
- (NSString *_Nullable)sw_parseBirthdayFromIdentityCard;
///从身份证号码中解析出性别字符串,e.g. 男,女 支持18位和15位身份证
- (NSString *_Nullable)sw_parseSexStringFromIdentityCard;
///从身份证号码中解析出性别码,e.g. 1男 2女 支持18位和15位身份证
- (NSString *_Nullable)sw_parseSexCodeFromIdentityCard;
///从身份证号码中解析出年龄,e.g. 18 支持18位和15位身份证
- (NSString *_Nullable)sw_parseAgeFromIdentityCard;

/**
 判断是否是邮箱账号
 */
- (BOOL)isEmailString __deprecated;

/**
 判断是否是身份证号码
 */
- (BOOL)isValidateIdentityCard __deprecated;

@end

NS_ASSUME_NONNULL_END
