
//
//  CALayer+SWExtension.m
//  Pods
//
//  Created by zhoushaowen on 2020/9/10.
//

#import "CALayer+SWExtension.h"

@implementation CALayer (SWExtension)

- (void)setSw_borderUIColor:(UIColor *)sw_borderUIColor {
    self.borderColor = sw_borderUIColor.CGColor;
}

- (UIColor*)sw_borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setSw_shadowUIColor:(UIColor *)sw_shadowUIColor {
    self.shadowColor = sw_shadowUIColor.CGColor;
}

- (UIColor *)sw_shadowUIColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
