//
//  NSArray+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2020/10/16.
//  Copyright © 2020 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SWExtension)

/// 数组去重
/// @param key 根据数组中对象的那个key来去重 如果数组中存的是NSNumber或者NSString类型传nil即可
- (NSArray *)sw_removeDuplicatesByKey:(NSString *_Nullable)key;

@end

NS_ASSUME_NONNULL_END
