//
//  UITableView+SWCacheExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/12.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "UITableView+SWCacheExtension.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic,strong) NSCache *sw_rowHeightCache;

@end

@implementation UITableView (SWCacheExtension)

+ (void)sw_exchangeMethodWithSystemSelector:(SEL)systemSel customSelector:(SEL)customSel {
    Method systemMethod = class_getInstanceMethod([self class], systemSel);
    Method customMethod = class_getInstanceMethod([self class], customSel);
    if(class_addMethod([self class], systemSel, method_getImplementation(customMethod), method_getTypeEncoding(customMethod))){
        class_replaceMethod([self class], customSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
}

+ (void)load {
    [self sw_exchangeMethodWithSystemSelector:@selector(reloadData) customSelector:@selector(sw_reloadData)];
}

- (void)setSw_rowHeightCache:(NSCache *)sw_rowHeightCache {
    objc_setAssociatedObject(self, @selector(sw_rowHeightCache), sw_rowHeightCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSCache *)sw_rowHeightCache {
    NSCache *cache = objc_getAssociatedObject(self, @selector(sw_rowHeightCache));
    if(cache == nil){
        cache = [[NSCache alloc] init];
        self.sw_rowHeightCache = cache;
    }
    return cache;
}

- (void)sw_reloadData {
    [self.sw_rowHeightCache removeAllObjects];
    [self sw_reloadData];
}

- (void)sw_setRowHeight:(CGFloat)rowHeight forIndexPath:(NSIndexPath *)indexPath {
    NSString *cacheKey = [NSString stringWithFormat:@"SWRowHeightCacheKey_%@_%@",@(indexPath.section),@(indexPath.row)];
    [self.sw_rowHeightCache setObject:@(rowHeight) forKey:cacheKey];
}

- (CGFloat)sw_rowHeightForIndexPath:(NSIndexPath *)indexPath {
    NSString *cacheKey = [NSString stringWithFormat:@"SWRowHeightCacheKey_%@_%@",@(indexPath.section),@(indexPath.row)];
    NSNumber *value = [self.sw_rowHeightCache objectForKey:cacheKey];
    return value?[value floatValue]:-1;
}

@end
