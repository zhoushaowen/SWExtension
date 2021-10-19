//
//  NSString+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/3/1.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "NSString+SWExtension.h"

@implementation NSString (SWExtension)

- (NSString * _Nonnull)sw_safeSubstringFromIndex:(NSUInteger)from {
    if((NSInteger)from - 1 >= (NSInteger)self.length) return @"";
    return [self substringFromIndex:from];
}

- (NSString *_Nonnull)sw_safeSubstringToIndex:(NSUInteger)to {
    if((NSInteger)to - 1 >= (NSInteger)self.length) return @"";
    return [self substringToIndex:to];
}

- (NSString *_Nonnull)sw_safeSubstringWithRange:(NSRange)range {
    if((NSInteger)range.location - 1 >= (NSInteger)self.length) return @"";
    if((NSInteger)range.location + (NSInteger)range.length - 1 > (NSInteger)self.length) return @"";
    return [self substringWithRange:range];
}

- (NSString *_Nullable)sw_encodeToBase64String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
    return base64Str;
}

- (NSString *_Nullable)sw_decodeBase64String {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

- (NSString *_Nullable)sw_trimming {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)sw_isEmptyString {
    return self.sw_trimming.length == 0;
}

- (BOOL)sw_isNotEmptyString {
    return ![self sw_isEmptyString];
}

+ (NSString *)sw_fixAccuracyWithString:(NSString *)incorrectString {
    double doubleValue = [incorrectString doubleValue];
    NSDecimalNumber *number  = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",doubleValue]];
    return [number stringValue];
}

+ (NSString *)sw_fixAccuracyWithDouble:(double)incorrectDouble {
    NSDecimalNumber *number  = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",incorrectDouble]];
    return [number stringValue];
}

- (BOOL)sw_isPhoneNumber {
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

+ (NSString *)sw_parseFromDeviceToken:(NSData *)deviceToken {
    if (![deviceToken isKindOfClass:[NSData class]]) return nil;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 13.0){
        const unsigned *tokenBytes = [deviceToken bytes];
        NSString *token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        NSLog(@"deviceToken:%@",token);
        return token;
    }else{
        NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"deviceToken:%@",token);
        return token;
    }
}

- (NSString *)sw_stringByAddingPercentEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *)sw_integerToChineseNumber:(NSInteger)integer {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    return [formatter stringFromNumber:[NSNumber numberWithInteger:integer]];
}


/**
 将中文字符串转换为拼音格式（带声调）
 @return 返回带声调拼音字符串
 */
- (NSString *)sw_transformToPinyinTone
{
    // 空值判断
    if (self.sw_trimming.length == 0) {
        return @"";
    }
    // 将字符串转为NSMutableString类型
    NSMutableString *string = [self mutableCopy];
    // 将字符串转换为拼音音调格式
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformMandarinLatin, NO);
    // 返回带声调拼音字符串
    return string;
}
 
 
/**
 将中文字符串转换为拼音格式（不带声调）
 @return 返回不带声调拼音字符串
 */
- (NSString *)sw_transformToPinyin
{
    // 空值判断
    if (self.sw_trimming.length == 0) {
        return @"";
    }
    // 将字符串转为NSMutableString类型
    NSMutableString *string = [self mutableCopy];
    // 将字符串转换为拼音音调格式
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformMandarinLatin, NO);
    // 去掉音调符号
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformStripDiacritics, NO);
    // 返回不带声调拼音字符串
    return string;
}
 
 
/**
 将中字符串转换为拼音首字母
 @return 拼音首字母字符串
 */
- (NSString *)sw_transformToFirstLetter
{
    // 空值判断
    if (self.sw_trimming.length == 0) {
        return @"";
    }
    // 首字母存储
    NSMutableString *firstLetterStirng = [NSMutableString string];
    // 遍历字符串中的所有字符
    for (NSUInteger i = 0; i < self.length; i++) {
        // 将每个字符截取后进行拼音转换
        NSString *charStr = [self substringWithRange:NSMakeRange(i, 1)];
        NSString *pinyin = [charStr sw_transformToPinyin];
        // 存储转换后的拼音首字母
        [firstLetterStirng appendString:[pinyin substringToIndex:1]];
    }
    // 返回中文首字母字符串
    return [firstLetterStirng uppercaseString];
}

@end
