//
//  NSString+SWEmoji.m
//  Chat
//
//  Created by 周少文 on 2016/11/1.
//  Copyright © 2016年 周少文. All rights reserved.
//

#import "NSString+SWEmoji.h"

@implementation NSString (SWEmoji)

+ (instancetype)emojiWithHexString:(NSString *)hexStr
{
    NSScanner *scanner = [[NSScanner alloc] initWithString:hexStr];
    unsigned int result = 0;
    [scanner scanHexInt:&result];
    char chars[4];
    int len = 4;
    
    chars[0] = (result >> 24) & (1 << 24) - 1;
    chars[1] = (result >> 16) & (1 << 16) - 1;
    chars[2] = (result >> 8) & (1 << 8) - 1;
    chars[3] = result & (1 << 8) - 1;
    NSString *emojiStr = [[NSString alloc] initWithBytes:chars length:len encoding:NSUTF32StringEncoding];
    return emojiStr;
}

//本方法摘自网络 随着iOS系统更新 不断完善中
- (BOOL)sw_isContainEmojiString {
    __block BOOL containsEmoji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0,
                                                    [self length])
                                options:NSStringEnumerationByComposedCharacterSequences
                             usingBlock:^(NSString *substring,
                                          NSRange substringRange,
                                          NSRange enclosingRange,
                                          BOOL *stop)
        {
            const unichar hs = [substring characterAtIndex:0];
            // surrogate pair
            if (0xd800 <= hs && hs <= 0xdbff)
            {
                if (substring.length > 1)
                {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
//                    if (0x1d000 <= uc && uc <= 0x1f9c0)
                    if (0x1d000 <= uc && uc <= 0x1fa73)
                    {
                        containsEmoji = YES;
                    }
                }
            }
            else if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3 ||
                    ls == 0xfe0f ||
                    ls == 0xd83c)
                {
                    containsEmoji = YES;
                }
            }
            else
            {
                // non surrogate
                if (0x2100 <= hs &&
                    hs <= 0x27ff)
                {
                    containsEmoji = YES;
                }
                else if (0x2B05 <= hs &&
                         hs <= 0x2b07)
                {
                    containsEmoji = YES;
                }
                else if (0x2934 <= hs &&
                         hs <= 0x2935)
                {
                    containsEmoji = YES;
                }
                else if (0x3297 <= hs &&
                         hs <= 0x3299)
                {
                    containsEmoji = YES;
                }
                else if (hs == 0xa9 ||
                         hs == 0xae ||
                         hs == 0x303d ||
                         hs == 0x3030 ||
                         hs == 0x2b55 ||
                         hs == 0x2b1c ||
                         hs == 0x2b1b ||
                         hs == 0x2b50)
                {
                    containsEmoji = YES;
                }
            }
            
            if (containsEmoji)
            {
                *stop = YES;
            }
        }];
       
       return containsEmoji;
    
}

@end
