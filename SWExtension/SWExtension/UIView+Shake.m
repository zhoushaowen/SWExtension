//
//  UIView+Shake.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)

- (void)shakeAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.35f;
    CGFloat x = self.layer.position.x;
    animation.values = @[@(x - 30), @(x + 30), @(x + 20), @(x - 20), @(x + 10), @(x - 10), @(x + 5), @(x - 5)];
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end
