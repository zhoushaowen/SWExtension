//
//  UIView+SWAutoLayout.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SWAutoLayout)

- (NSArray<__kindof NSLayoutConstraint*> *)sw_addConstraintsWithFormat:(NSString *)format options:(NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views;

- (NSLayoutConstraint *)sw_addConstraintToView:(UIView *)view withEqualAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant;

- (NSLayoutConstraint *)sw_addConstraintWith:(NSLayoutAttribute)attribute1 toView:(UIView *)view attribute:(NSLayoutAttribute)attribute2 constant:(CGFloat)constant;

@end
