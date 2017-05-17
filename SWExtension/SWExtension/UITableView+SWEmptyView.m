//
//  UITableView+SWEmptyView.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UITableView+SWEmptyView.h"
#import <objc/runtime.h>

static void *SW_EmptyView_Key = &SW_EmptyView_Key;
static void *SW_DisableAutomaticShowAndHideEmptyView_Key = &SW_DisableAutomaticShowAndHideEmptyView_Key;
static NSString *const SWTableEmptyViewIdentifier = @"SWTableEmptyViewIdentifier";

@implementation UITableView (SWEmptyView)

+ (void)load {
    Method systemMethod = class_getInstanceMethod([self class], @selector(reloadData));
    Method customMethod = class_getInstanceMethod([self class], @selector(sw_reloadData));
    method_exchangeImplementations(systemMethod, customMethod);
}

- (void)sw_reloadData {
    [self sw_reloadData];
    if(self.disableAutomaticShowAndHideEmptyView) return;
    if([self numberOfSections] <= 1){
        if([self numberOfRowsInSection:0] > 0){
            [self sw_hideEmptyView];
        }else{
            [self sw_showEmptyView];
        }
    }
    if(self.numberOfSections == 0){
        [self sw_showEmptyView];
        return;
    }
    for(int i=0;i<self.numberOfSections;i++){
        if([self numberOfRowsInSection:i] == 0){
            [self sw_showEmptyView];
            return;
        }
    }
    [self sw_hideEmptyView];
}

- (void)setDisableAutomaticShowAndHideEmptyView:(BOOL)disableAutomaticShowAndHideEmptyView {
    objc_setAssociatedObject(self, SW_DisableAutomaticShowAndHideEmptyView_Key, @(disableAutomaticShowAndHideEmptyView), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)disableAutomaticShowAndHideEmptyView {
    return [objc_getAssociatedObject(self, SW_DisableAutomaticShowAndHideEmptyView_Key) boolValue];
}

- (void)setSw_emptyView:(UIView *)sw_emptyView {
    sw_emptyView.accessibilityIdentifier = SWTableEmptyViewIdentifier;
    objc_setAssociatedObject(self, SW_EmptyView_Key, sw_emptyView, OBJC_ASSOCIATION_RETAIN);
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj.accessibilityIdentifier isEqualToString:SWTableEmptyViewIdentifier]){
            [obj removeFromSuperview];
            *stop = YES;
        }
    }];
}

- (UIView *)sw_emptyView {
    return objc_getAssociatedObject(self, SW_EmptyView_Key);
}

- (void)sw_showEmptyView {
    if(self.sw_emptyView == nil) return;
    if(self.sw_emptyView.superview == nil){
        self.sw_emptyView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.sw_emptyView];
    }
    [self bringSubviewToFront:self.sw_emptyView];
}

- (void)sw_hideEmptyView {
    [self.sw_emptyView removeFromSuperview];
}

@end
