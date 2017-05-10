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
static NSString *const SWTableEmptyViewIdentifier = @"SWTableEmptyViewIdentifier";

@implementation UITableView (SWEmptyView)

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
        self.sw_emptyView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+self.contentOffset.y);
        self.sw_emptyView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.sw_emptyView];
    }
    [self bringSubviewToFront:self.sw_emptyView];
}

- (void)sw_hideEmptyView {
    [self.sw_emptyView removeFromSuperview];
}

@end
