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

@end

