//
//  UIImageView+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SWExtension)

/**
 创建一个指定contentMode的imageView,
 如果contentMode为UIViewContentModeScaleAspectFill,
 那么imageView的clipsToBounds自定设置成YES.
 */
+ (instancetype)sw_imageViewWithContentMode:(UIViewContentMode)contentMode;

@end
