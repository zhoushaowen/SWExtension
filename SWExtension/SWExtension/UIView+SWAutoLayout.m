//
//  UIView+SWAutoLayout.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIView+SWAutoLayout.h"

@implementation UIView (SWAutoLayout)

- (NSArray<__kindof NSLayoutConstraint*> *)sw_addAutoLayoutWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views
{
    if(self.translatesAutoresizingMaskIntoConstraints)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSArray *array = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0f)
    {
        [NSLayoutConstraint activateConstraints:array];
    }else{
        [self.superview addConstraints:array];
    }
    return array;
}

- (NSLayoutConstraint *)sw_addConstraintToView:(UIView *)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant
{
    if(self.translatesAutoresizingMaskIntoConstraints)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1.0f constant:constant];
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0f)
    {
        constraint.active = YES;
    }else{
        [self.superview addConstraint:constraint];
    }
    
    return constraint;
}

- (NSLayoutConstraint *)sw_addConstraintWith:(NSLayoutAttribute)attribute1 toView:(UIView *)view attribute:(NSLayoutAttribute)attribute2 constant:(CGFloat)constant
{
    if(self.translatesAutoresizingMaskIntoConstraints)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute1 relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute2 multiplier:1.0f constant:constant];
    if([[UIDevice currentDevice].systemVersion floatValue]>=8.0f)
    {
        constraint.active = YES;
    }else{
        [self.superview addConstraint:constraint];
    }
    
    return constraint;
}

@end
