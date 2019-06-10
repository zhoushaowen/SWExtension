//
//  UIView+SWCornerStyle.m
//  Pharmacist-role
//
//  Created by zhoushaowen on 2019/6/4.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "UIView+SWCornerStyle.h"
#import <RACEXTScope.h>
#import <NSObject+RACKVOWrapper.h>
#import <RACDisposable.h>
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,strong) RACDisposable *swCornerStyleDisposable;

@end

@implementation UIView (SWCornerStyle)

- (void)sw_setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii isHalfTheHeight:(BOOL)isHalfTheHeight {
    if(self.swCornerStyleDisposable){
        [self.swCornerStyleDisposable dispose];
    }
    @weakify(self)
    self.swCornerStyleDisposable = [self rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self)
        CGSize size = cornerRadii;
        if(isHalfTheHeight){
            CGFloat value = self.bounds.size.height/2.0;
            size = CGSizeMake(value, value);
        }
        UIBezierPath *bezizerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = bezizerPath.CGPath;
        self.layer.mask = layer;
    }];
}

- (void)sw_setDefaultRoundingCorners:(UIRectCorner)corners {
    [self sw_setRoundingCorners:corners cornerRadii:CGSizeZero isHalfTheHeight:YES];
}

- (void)sw_setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    [self sw_setRoundingCorners:corners cornerRadii:cornerRadii isHalfTheHeight:NO];
}

- (void)setSwCornerStyleDisposable:(RACDisposable *)swCornerStyleDisposable {
    objc_setAssociatedObject(self, @selector(swCornerStyleDisposable), swCornerStyleDisposable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RACDisposable *)swCornerStyleDisposable {
    return objc_getAssociatedObject(self, @selector(swCornerStyleDisposable));
}

@end