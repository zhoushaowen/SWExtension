//
//  UIViewController+SWAlertController.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SWAlertController)

/**
 弹出一个带有红色按钮和一个取消按钮的alert

 @param destructiveTitle 红色按钮的标题
 @param title alert标题
 @param message alert内容
 @param handler 红色按钮点击回调
 */
- (void)sw_showAlertWithDestructiveActionTitle:(NSString *)destructiveTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler;

/**
 弹出一个带有普通颜色按钮和一个取消按钮的alert

 @param actionTitle 普通按钮的标题
 @param title alert标题
 @param message alert内容
 @param handler 红色按钮点击回调
 */
- (void)sw_showAlertWithDefaultActionTitle:(NSString *)actionTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler;

/**
 弹出一个多个按钮的alert

 @param actionTitles 按钮标题数组
 @param title alert标题
 @param message alert内容
 @param handler 按钮点击回调
 */
- (void)sw_showAlertWithActionTitles:(NSArray<NSString *> *)actionTitles title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler;

/**
 弹出一个仅有一个按钮的alert

 @param onlyActionTitle 仅有的按钮标题
 @param title alert标题
 @param message alert内容
 @param handler 按钮点击回调
 */
- (void)sw_showAlertWithOnlyActionTitle:(NSString *)onlyActionTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler;

/**
 弹出一个带取消按钮和多个action按钮的actionSheet

 @param actionTitles 按钮标题数组
 @param handler 按钮点击回调
 */
- (void)sw_showActionSheetWithActionTitles:(NSArray<NSString *> *)actionTitles handler:(void(^)(UIAlertAction *action))handler;

/**
 弹出一个可以自定义取消按钮和多个action按钮的actionSheet

 @param actionTitles 按钮标题数组
 @param cancelTitle 取消按钮的标题
 @param handler 按钮点击回调
 */
- (void)sw_showActionSheetWithActionTitles:(NSArray<NSString *> *)actionTitles cancelTitle:(NSString *)cancelTitle handler:(void(^)(UIAlertAction *action))handler;



@end
