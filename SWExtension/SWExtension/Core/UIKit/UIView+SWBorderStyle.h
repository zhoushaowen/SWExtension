//
//  UIView+SWBorderStyle.h
//  Pharmacist-role
//
//  Created by zhoushaowen on 2019/6/4.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SWBorderStyle)

@property (nonatomic) CGFloat sw_borderTopWidth;
@property (nonatomic) CGFloat sw_borderLeftWidth;
@property (nonatomic) CGFloat sw_borderBottomWidth;
@property (nonatomic) CGFloat sw_borderRightWidth;

@property (nonatomic,strong) UIColor *sw_borderTopColor;
@property (nonatomic,strong) UIColor *sw_borderLeftColor;
@property (nonatomic,strong) UIColor *sw_borderBottomColor;
@property (nonatomic,strong) UIColor *sw_borderRightColor;

@end

NS_ASSUME_NONNULL_END
