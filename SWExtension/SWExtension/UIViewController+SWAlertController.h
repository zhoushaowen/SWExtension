//
//  UIViewController+SWAlertController.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSWAlertActionStyle;
extern NSString *const kSWAlertActionTitle;

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

 @param title 标题
 @param message 标题下方的文字
 @param actionTitles 按钮标题
 @param handler 按钮点击回调
 */
- (void)sw_showActionSheetWithTitle:(NSString *)title messgae:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles handler:(void(^)(UIAlertAction *action))handler;

/**
 弹出一个可以自定义取消按钮和多个action按钮的actionSheet

 @param title 标题
 @param message 标题下方的文字
 @param actionTitles 按钮标题
 @param cancelTitle 取消按钮标题
 @param handler 按钮点击回调
 */
- (void)sw_showActionSheetWithTitle:(NSString *)title messgae:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles cancelTitle:(NSString *)cancelTitle handler:(void(^)(UIAlertAction *action))handler;

/**
 弹出一个带TextFiled的alert

 @param title 标题
 @param message 标题下方的文字
 @param configurationHandler textField配置回调
 @param actionInfo 按钮信息字典
 @param handler 按钮点击回调
 */
- (void)sw_showTextFieldAlertWithTitle:(NSString *)title message:(NSString *)message textFieldConfigurationHandler:(void(^)(UITextField *textField))configurationHandler actionInfo:(NSArray<NSDictionary *> *)actionInfo handler:(void(^)(UIAlertAction *action))handler;

@end
