//
//  NSMutableAttributedString+SWExtension1.h
//  SWExtension
//
//  Created by zhoushaowen on 2020/3/23.
//  Copyright © 2020 sw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (SWExtension)

+ (instancetype)sw_mutableAttributedStringWithString:(NSString *_Nonnull)string attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;
- (NSMutableAttributedString *)sw_addAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
