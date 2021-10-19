//
//  NSString+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2019/3/1.
//  Copyright © 2019 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SWExtension)

- (NSString * _Nonnull)sw_safeSubstringFromIndex:(NSUInteger)from;
- (NSString *_Nonnull)sw_safeSubstringToIndex:(NSUInteger)to;
- (NSString *_Nonnull)sw_safeSubstringWithRange:(NSRange)range;

/**
 将utf8字符串编码成base64字符串

 @return base64字符串
 */
- (NSString *_Nullable)sw_encodeToBase64String;

/**
 将base64字符串解码成普通字符串

 @return ut8编码的字符串
 */
- (NSString *_Nullable)sw_decodeBase64String;
/// 去掉字符串左右两边的空格和换行\n
- (NSString * _Nullable)sw_trimming;
/// 是否是空字符串 全是空格的字符串的字符串也算
- (BOOL)sw_isEmptyString;
/// 是否是非空字符串 全是空格的字符串的字符串也算
- (BOOL)sw_isNotEmptyString;


/// 解决json序列化导致服务端返回的浮点数精度丢失的问题
+ (NSString *)sw_fixAccuracyWithString:(NSString *)incorrectString;
+ (NSString *)sw_fixAccuracyWithDouble:(double)incorrectDouble;

/// 判断字符串是否是1开头的 11位数字手机号码
- (BOOL)sw_isPhoneNumber;

/// 解析deviceToken
+ (NSString *)sw_parseFromDeviceToken:(NSData *)deviceToken;

/// 对包含中文等特殊字符串的url进行编码
- (nullable NSString *)sw_stringByAddingPercentEncoding;

/// 阿拉伯数字转中文数字
/// @param integer 阿拉伯数字
+ (NSString *)sw_integerToChineseNumber:(NSInteger)integer;
/**
 将中文字符串转换为拼音格式（带声调）
 @return 返回带声调拼音字符串
 */
- (NSString *)sw_transformToPinyinTone;
/**
 将中文字符串转换为拼音格式（不带声调）
 @return 返回不带声调拼音字符串
 */
- (NSString *)sw_transformToPinyin;
/**
 将中字符串转换为拼音首字母
 @return 拼音首字母字符串
 */
- (NSString *)sw_transformToFirstLetter;

NS_ASSUME_NONNULL_END


@end

