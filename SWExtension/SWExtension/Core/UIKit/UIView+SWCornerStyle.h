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

/// 已知问题:不要将该属性直接作用于UITableView上,否则会导致UITableView的高度出现问题
- (void)sw_setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
/**
 the defalue cornerRadis is half the height
 */
- (void)sw_setDefaultRoundingCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
