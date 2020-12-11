//
//  UIView+SWExtension.h
//  test
//
//  Created by zhoushaowen on 2018/6/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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
- (void)sw_addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withDelegate:(id<UIGestureRecognizerDelegate> _Nullable)delegate actionBlock:(SWGestureActionBlock)gestureActionBlock;
- (void)sw_addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withActionBlock:(SWGestureActionBlock)gestureActionBlock;

///给UIView添加一个Tap手势
- (void)sw_addTapGestureRecognizerWithActionBlock:(SWGestureActionBlock _Nullable)gestureActionBlock;
///给UIView添加一个Tap手势 内部已设置手势delegate
- (void)sw_addTapGestureRecognizerWithActionBlock:(SWGestureActionBlock _Nullable)gestureActionBlock gestureRecognizerShouldReceiveTouch:(BOOL(^_Nullable)(UIGestureRecognizer *ges,UITouch *touch))gestureRecognizerShouldReceiveTouch;

///给UIView添加一个Tap手势 内部已设置手势delegate 多次添加也只会存在一个Tap手势(会自动移除上一次添加的)
- (void)sw_tapGestureRecognizerWithActionBlock:(SWGestureActionBlock)gestureActionBlock gestureRecognizerShouldReceiveTouch:(BOOL(^_Nullable)(UIGestureRecognizer *ges,UITouch *touch))gestureRecognizerShouldReceiveTouch;
///给UIView添加一个Tap手势 内部已设置手势delegate 多次添加也只会存在一个Tap手势(会自动移除上一次添加的)
- (void)sw_tapGestureRecognizerWithActionBlock:(SWGestureActionBlock _Nullable)gestureActionBlock;

@end

NS_ASSUME_NONNULL_END
