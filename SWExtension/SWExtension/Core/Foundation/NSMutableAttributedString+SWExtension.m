//
//  NSMutableAttributedString+SWExtension1.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/3/23.
//  Copyright © 2020 sw. All rights reserved.
//

#import "NSMutableAttributedString+SWExtension.h"

@implementation NSMutableAttributedString (SWExtension)

+ (instancetype)sw_mutableAttributedStringWithString:(NSString *_Nonnull)string attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attrs];
    return attriStr;
}

- (NSMutableAttributedString *)sw_addAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes range:(NSRange)range {
    [self addAttributes:attributes range:range];
    return self;
}

@end
