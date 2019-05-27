//
//  NSString+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2019/3/1.
//  Copyright © 2019 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end

