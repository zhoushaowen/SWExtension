//
//  NSArray+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/10/16.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "NSArray+SWExtension.h"

@implementation NSArray (SWExtension)

- (NSArray *)sw_removeDuplicatesByKey:(NSString *)key {
    NSMutableSet *uniqueKeys = [NSMutableSet set];
    NSMutableArray *uniqueObjs = [NSMutableArray arrayWithCapacity:0];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [uniqueKeys addObject:[NSString stringWithFormat:@"%@",key?[obj valueForKey:key]:obj]];
    }];
    [uniqueKeys enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
            if([[NSString stringWithFormat:@"%@",key?[obj2 valueForKey:key]:obj2] isEqualToString:obj]){
                [uniqueObjs addObject:obj2];
                *stop2 = YES;
            }
        }];
    }];
    return [uniqueObjs copy];
}
- (NSArray<NSArray *> *)sw_groupByKey:(NSString *)key {
    NSMutableSet *uniqueKeys = [NSMutableSet set];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [uniqueKeys addObject:[NSString stringWithFormat:@"%@",key?[obj valueForKey:key]:obj]];
    }];
    NSMutableArray *groupArray= [NSMutableArray arrayWithCapacity:uniqueKeys.count];
    [uniqueKeys enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableArray *uniqueObjs = [NSMutableArray arrayWithCapacity:0];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
            if([[NSString stringWithFormat:@"%@",key?[obj2 valueForKey:key]:obj2] isEqualToString:obj]){
                [uniqueObjs addObject:obj2];
            }
        }];
        if(uniqueObjs.count > 0){
            [groupArray addObject:[uniqueObjs copy]];
        }
    }];
    return [groupArray copy];
}

- (void)sw_sortArrayAsABCDGroupByKey:(NSString *)key hook:(NSString *(^)(id hookObj))hook completedBlock:(void(^)(NSArray<NSArray *> *groupSortedArray,NSArray<NSString *> *indexTitles))completedBlock {
    UILocalizedIndexedCollation *collaction = [UILocalizedIndexedCollation currentCollation];
    NSInteger count = collaction.sectionTitles.count;//A,B,C...Z,#
    NSMutableArray<NSMutableArray *> *letterArraysInArray = [NSMutableArray arrayWithCapacity:count];
    for(int i=0;i<count;i++){
        NSMutableArray *letterArray = [NSMutableArray arrayWithCapacity:0];
        [letterArraysInArray addObject:letterArray];
    }
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj valueForKey:key] == nil){
            [obj setValue:@"" forKey:key];
        }
        if(hook){
            NSString *str = hook(obj);
            if(str.length > 0){
                NSUInteger index = [collaction.sectionTitles indexOfObject:[str uppercaseString]];
                if(index < letterArraysInArray.count){
                    NSMutableArray *letterArray = letterArraysInArray[index];
                    [letterArray addObject:obj];
                    return;
                }
            }
        }
        NSInteger section = [collaction sectionForObject:obj collationStringSelector:NSSelectorFromString(key)];
        NSMutableArray *letterArray = letterArraysInArray[section];
        [letterArray addObject:obj];
    }];
    NSMutableArray *copyArray = [letterArraysInArray mutableCopy];
    NSMutableArray *sectionTitles = [NSMutableArray arrayWithCapacity:0];
    [letterArraysInArray enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull letterArray, NSUInteger idx, BOOL * _Nonnull stop) {
        if(letterArray.count > 0){
            NSArray *sortedArray = [collaction sortedArrayFromArray:letterArray collationStringSelector:NSSelectorFromString(key)];
            [copyArray replaceObjectAtIndex:idx withObject:sortedArray];
            [sectionTitles addObject:collaction.sectionTitles[idx]];
        }
    }];
    [letterArraysInArray enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull letterArray, NSUInteger idx, BOOL * _Nonnull stop) {
        if(letterArray.count < 1){
            [copyArray removeObject:letterArray];
        }
    }];
    if(completedBlock){
        completedBlock([copyArray copy],[sectionTitles copy]);
    }
}

#pragma mark - 避免操作数组crash的方法
- (id)sw_safe_objectAtIndex:(NSUInteger)index {
    if(![self isKindOfClass:[NSArray class]]) return nil;
    if(index > self.count - 1){
        return nil;
    }
    if(self.count == 0) return nil;
    return [self objectAtIndex:index];
}




@end
