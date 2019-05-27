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

@interface SWAlertAction : UIAlertAction

@property (nonatomic,readonly) NSInteger index;

@end

@interface UIViewController (SWAlertController)

/**
 弹出一个红色按钮和一个取消按钮的alert
 
 @param destructiveTitle 红色按钮的标题
 @param cancelTitle 取消标题
 @param alertTitle alert标题
 @param alertMessage alert内容
 @param handler 按钮点击回调
 @param completedBlock 弹出完成的回调
 */
- (UIAlertController *)sw_presentAlertWithDestructiveActionTitle:(NSString *)destructiveTitle cancelActionTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock;
/**
 弹出一个默认按钮和一个取消按钮的alert

 @param defaultTitle 默认按钮的标题
 @param cancelTitle 取消标题
 @param alertTitle alert标题
 @param alertMessage alert内容
 @param handler 按钮点击回调
 @param completedBlock 弹出完成的回调
 */
- (UIAlertController *)sw_presentAlertWithDefaultActionTitle:(NSString *)defaultTitle cancelActionTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock;
/**
 弹出多个可自定义按钮的alert

 @param actionTitles 按钮的标题数组
 @param styleArray 按钮风格数组
 @param alertTitle alert标题
 @param alertMessage alert内容
 @param handler 按钮点击回调
 @param completedBlock 弹出完成的回调
 */
- (UIAlertController *)sw_presentAlertWithActionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock;
/**
 弹出仅有一个按钮的alert

 @param onlyActionTitle 仅有按钮的标题
 @param style 仅有按钮风格
 @param alertTitle alert标题
 @param alertMessage alert内容
 @param handler 按钮点击回调
 @param completedBlock 弹出完成的回调
 */
- (UIAlertController *)sw_presentAlertWithOnlyActionTitle:(NSString *)onlyActionTitle style:(UIAlertActionStyle)style alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock;
/**
 弹出actionSheet,带有取消按钮和多个action按钮

 @param sheetTitle actionSheet标题
 @param sheetMessgae actionSheet内容
 @param actionTitles 标题数组
 @param styleArray 标题风格数组
 @param cancelTitle 取消按钮标题
 @param handler 按钮点击回调
 @param completedBlock 弹出完成的回调
 */
- (UIAlertController *)sw_presentActionSheetWithSheetTitle:(NSString *)sheetTitle sheetMessgae:(NSString *)sheetMessgae actionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray cancelActionTitle:(NSString *)cancelTitle handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock;

/**
 弹出一个带TextFiled的alert
 
 @param alertTitle alert标题
 @param alertMessage alert内容
 @param actionTitles 按钮标题数组
 @param styleArray 标题风格数组
 @param configurationHandler textField配置回调,可以在里面设置UITextField文字颜色等等
 @param handler 按钮点击回调
 @param completedBlock 弹出完成的回调
 */
- (UIAlertController *)sw_presentTextFieldAlertWithAlertTitle:(NSString *)alertTitle alertMessgae:(NSString *)alertMessage actionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray textFieldConfigurationHandler:(void(^)(UITextField *textField))configurationHandler handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock;


/**
 弹出一个带有红色按钮和一个取消按钮的alert

 @param destructiveTitle 红色按钮的标题
 @param title alert标题
 @param message alert内容
 @param handler 红色按钮点击回调
 */
- (void)sw_showAlertWithDestructiveActionTitle:(NSString *)destructiveTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler __deprecated;

/**
 弹出一个带有普通颜色按钮和一个取消按钮的alert

 @param actionTitle 普通按钮的标题
 @param title alert标题
 @param message alert内容
 @param handler 红色按钮点击回调
 */
- (void)sw_showAlertWithDefaultActionTitle:(NSString *)actionTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler __deprecated;

/**
 弹出一个多个按钮的alert

 @param actionTitles 按钮标题数组
 @param title alert标题
 @param message alert内容
 @param handler 按钮点击回调
 */
- (void)sw_showAlertWithActionTitles:(NSArray<NSString *> *)actionTitles title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler __deprecated;

/**
 弹出一个仅有一个按钮的alert

 @param onlyActionTitle 仅有的按钮标题
 @param title alert标题
 @param message alert内容
 @param handler 按钮点击回调
 */
- (void)sw_showAlertWithOnlyActionTitle:(NSString *)onlyActionTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler __deprecated;

/**
 弹出一个带取消按钮和多个action按钮的actionSheet

 @param title 标题
 @param message 标题下方的文字
 @param actionTitles 按钮标题
 @param handler 按钮点击回调
 */
- (void)sw_showActionSheetWithTitle:(NSString *)title messgae:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles handler:(void(^)(UIAlertAction *action))handler __deprecated;

/**
 弹出一个可以自定义取消按钮和多个action按钮的actionSheet

 @param title 标题
 @param message 标题下方的文字
 @param actionTitles 按钮标题
 @param cancelTitle 取消按钮标题
 @param handler 按钮点击回调
 */
- (void)sw_showActionSheetWithTitle:(NSString *)title messgae:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles cancelTitle:(NSString *)cancelTitle handler:(void(^)(UIAlertAction *action))handler __deprecated;

/**
 弹出一个带TextFiled的alert

 @param title 标题
 @param message 标题下方的文字
 @param configurationHandler textField配置回调
 @param actionInfo 按钮信息字典
 @param handler 按钮点击回调
 */
- (void)sw_showTextFieldAlertWithTitle:(NSString *)title message:(NSString *)message textFieldConfigurationHandler:(void(^)(UITextField *textField))configurationHandler actionInfo:(NSArray<NSDictionary *> *)actionInfo handler:(void(^)(UIAlertAction *action))handler __deprecated;






@end
