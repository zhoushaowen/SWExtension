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

/// 将数组中的元素根据字段值按照A,B,C...Z,#分组 常用于通讯录好友分组
/// @param key 需要分组的字段
/// @param hook 拦截需要特殊处理的对象
/// @param completedBlock 分组完成回调
- (void)sw_sortArrayAsABCDGroupByKey:(NSString *)key hook:(NSString *(^)(id hookObj))hook completedBlock:(void(^)(NSArray<NSArray *> *groupSortedArray,NSArray<NSString *> *indexTitles))completedBlock;
/// 数组分组
/// @param key 根据数组中对象的那个key来分组 如果数组中存的是NSNumber或者NSString类型传nil即可
- (NSArray<NSArray *> *)sw_groupByKey:(NSString *)key;
- (id)sw_safe_objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
