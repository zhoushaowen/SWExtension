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
