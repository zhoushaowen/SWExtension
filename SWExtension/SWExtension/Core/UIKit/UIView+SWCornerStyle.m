//
//  UIView+SWCornerStyle.m
//  Pharmacist-role
//
//  Created by zhoushaowen on 2019/6/4.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "UIView+SWCornerStyle.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,weak) RACDisposable *swCornerStyleDisposable;

@end

@implementation UIView (SWCornerStyle)

- (void)sw_setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii isHalfTheHeight:(BOOL)isHalfTheHeight {
    if(self.swCornerStyleDisposable){
        [self.swCornerStyleDisposable dispose];
    }
    @weakify(self)
    self.swCornerStyleDisposable = [[RACSignal merge:@[RACObserve(self, frame),RACObserve(self, bounds)]] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        CGSize size = cornerRadii;
        if(isHalfTheHeight){
            CGFloat value = self.frame.size.height/2.0;
            size = CGSizeMake(value, value);
        }
        UIBezierPath *bezizerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) byRoundingCorners:corners cornerRadii:size];
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
    objc_setAssociatedObject(self, @selector(swCornerStyleDisposable), swCornerStyleDisposable, OBJC_ASSOCIATION_ASSIGN);
}

- (RACDisposable *)swCornerStyleDisposable {
    return objc_getAssociatedObject(self, @selector(swCornerStyleDisposable));
}


@end
