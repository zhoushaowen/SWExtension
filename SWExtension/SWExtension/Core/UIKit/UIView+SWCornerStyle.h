//
//  UIView+SWCornerStyle.h
//  Pharmacist-role
//
//  Created by zhoushaowen on 2019/6/4.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SWCornerStyle)

- (void)sw_setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
/**
 the defalue cornerRadis is half the height
 */
- (void)sw_setDefaultRoundingCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
