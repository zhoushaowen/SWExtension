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

@property (nonatomic,strong) RACDisposable *swCornerStyleFrameDisposable;
@property (nonatomic,strong) RACDisposable *swCornerStyleBoundsDisposable;

@end

@implementation UIView (SWCornerStyle)

- (void)sw_setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii isHalfTheHeight:(BOOL)isHalfTheHeight {
    if(self.swCornerStyleFrameDisposable){
        [self.swCornerStyleFrameDisposable dispose];
    }
    @weakify(self)
    self.swCornerStyleFrameDisposable = [self rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
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
    if(self.swCornerStyleBoundsDisposable){
        [self.swCornerStyleBoundsDisposable dispose];
    }
    //某些情况下基于autolayout布局的控件大小发生变化的时候不会触发frame的kvo,但是却会触发bounds的kvo
    self.swCornerStyleBoundsDisposable = [self rac_observeKeyPath:@"bounds" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
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

- (void)setSwCornerStyleFrameDisposable:(RACDisposable *)swCornerStyleFrameDisposable {
    objc_setAssociatedObject(self, @selector(swCornerStyleFrameDisposable), swCornerStyleFrameDisposable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RACDisposable *)swCornerStyleFrameDisposable {
    return objc_getAssociatedObject(self, @selector(swCornerStyleFrameDisposable));
}

- (void)setSwCornerStyleBoundsDisposable:(RACDisposable *)swCornerStyleBoundsDisposable {
    objc_setAssociatedObject(self, @selector(swCornerStyleBoundsDisposable), swCornerStyleBoundsDisposable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RACDisposable *)swCornerStyleBoundsDisposable {
    return objc_getAssociatedObject(self, @selector(swCornerStyleBoundsDisposable));
}

@end
