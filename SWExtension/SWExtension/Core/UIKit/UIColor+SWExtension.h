//
//  UIColor+SWExtension.h
//  CloudPharmacy
//
//  Created by zhoushaowen on 2019/9/23.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (SWExtension)
/*
 兼容iOS13以下和低版本Xcode的方法
 注意:系统方法colorWithDynamicProvider中的block只有在color所在的view存在并且view已经被添加到superView上才会调用
 */
+ (UIColor *)sw_colorWithDynamicProvider:(UIColor *_Nullable(^)(BOOL isDarkAppearance))dynamicProvider;




@end

NS_ASSUME_NONNULL_END
