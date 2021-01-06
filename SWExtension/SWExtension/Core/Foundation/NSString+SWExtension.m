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
    if(from - 1 >= self.length) return @"";
    return [self substringFromIndex:from];
}

- (NSString *_Nonnull)sw_safeSubstringToIndex:(NSUInteger)to {
    if(to - 1 >= self.length) return @"";
    return [self substringToIndex:to];
}

- (NSString *_Nonnull)sw_safeSubstringWithRange:(NSRange)range {
    if(range.location - 1 >= self.length) return @"";
    if(range.location + range.length - 1 >= self.length) return @"";
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

@end
