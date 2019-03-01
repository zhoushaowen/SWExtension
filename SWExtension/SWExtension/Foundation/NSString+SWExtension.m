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

@end
