//
//  UIView+ShakeAnimation.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIView+ShakeAnimation.h"

#define angelToRandian(x)  ((x)/180.0*M_PI)

NSString *const SWShakeOnceAnimation = @"SWShakeOnceAnimation";
NSString *const SWShakeRepeatAnimation = @"SWShakeRepeatAnimation";

@implementation UIView (ShakeAnimation)

- (void)shakeOnceAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.35f;
    CGFloat x = self.layer.position.x;
    animation.values = @[@(x - 30), @(x + 30), @(x + 20), @(x - 20), @(x + 10), @(x - 10), @(x + 5), @(x - 5)];
    [self.layer addAnimation:animation forKey:SWShakeOnceAnimation];
}

- (void)shakeRepeatAnimation {
    CAKeyframeAnimation* anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angelToRandian(-1)),@(angelToRandian(1)),@(angelToRandian(-1))];
    anim.repeatCount = MAXFLOAT;
    anim.duration = 0.2;
    anim.removedOnCompletion = NO;
    [self.layer addAnimation:anim forKey:SWShakeRepeatAnimation];
}

@end
