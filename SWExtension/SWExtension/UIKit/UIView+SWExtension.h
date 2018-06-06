//
//  UIView+SWExtension.h
//  test
//
//  Created by zhoushaowen on 2018/6/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SWExtension)

/**
 获取UIView所在的controller
 如果当前view还没有被添加到superView上,那么获取到的controller为nil
 @return controller
 */
- (__kindof UIViewController *_Nullable)sw_viewController;

@end
