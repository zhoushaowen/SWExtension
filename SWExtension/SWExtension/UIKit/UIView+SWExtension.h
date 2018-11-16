//
//  UIView+SWExtension.h
//  test
//
//  Created by zhoushaowen on 2018/6/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SWGestureActionBlock)(UIGestureRecognizer *gestureRecognizer);

@interface UIView (SWExtension)

/**
 获取UIView所在的controller
 如果当前view还没有被添加到superView上,那么获取到的controller为nil
 @return controller
 */
- (__kindof UIViewController *_Nullable)sw_viewController;


/**
 给UIView添加手势
 */
- (void)sw_addGestureRecognizerWithClass:(Class)gestureRecognizerClass delegate:(id<UIGestureRecognizerDelegate> _Nullable)delegate actionBlock:(SWGestureActionBlock)gestureActionBlock;
- (void)sw_addGestureRecognizerWithGesture:(UIGestureRecognizer *)gestureRecognizer actionBlock:(SWGestureActionBlock)gestureActionBlock;

@end
