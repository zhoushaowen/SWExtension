//
//  UIViewController+SWAlertController.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIViewController+SWAlertController.h"

NSString *const kSWAlertActionStyle = @"kSWAlertActionStyle";
NSString *const kSWAlertActionTitle = @"kSWAlertActionTitle";

@implementation UIViewController (SWAlertController)

- (UIAlertController *)sw_presentAlertWithDestructiveActionTitle:(NSString *)destructiveTitle cancelActionTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(UIAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:handler]];
    [self presentViewController:alert animated:YES completion:completedBlock];
    return alert;
}

- (UIAlertController *)sw_presentAlertWithDefaultActionTitle:(NSString *)defaultTitle cancelActionTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(UIAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:defaultTitle style:UIAlertActionStyleDefault handler:handler]];
    [self presentViewController:alert animated:YES completion:completedBlock];
    return alert;
}

- (UIAlertController *)sw_presentAlertWithActionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(UIAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if(styleArray){
            style = (UIAlertActionStyle)styleArray[idx];
        }
        if(style < UIAlertActionStyleDefault || style > UIAlertActionStyleDestructive){
            style = UIAlertActionStyleDefault;
        }
        [alert addAction:[UIAlertAction actionWithTitle:obj style:style handler:handler]];
    }];
    [self presentViewController:alert animated:YES completion:completedBlock];
    return alert;
}

- (UIAlertController *)sw_presentAlertWithOnlyActionTitle:(NSString *)onlyActionTitle style:(UIAlertActionStyle)style alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(UIAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertActionStyle arr[1] = {style};
    return [self sw_presentAlertWithActionTitles:@[onlyActionTitle] styleArray:arr alertTitle:alertTitle alertMessage:alertMessage handler:handler completion:completedBlock];
}

- (UIAlertController *)sw_presentActionSheetWithSheetTitle:(NSString *)sheetTitle sheetMessgae:(NSString *)sheetMessgae actionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray cancelActionTitle:(NSString *)cancelTitle handler:(void(^)(UIAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sheetTitle message:sheetMessgae preferredStyle:UIAlertControllerStyleActionSheet];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if(styleArray){
            style = (UIAlertActionStyle)styleArray[idx];
        }
        if(style < UIAlertActionStyleDefault || style > UIAlertActionStyleDestructive){
            style = UIAlertActionStyleDefault;
        }
        [alertController addAction:[UIAlertAction actionWithTitle:actionTitles[idx] style:style handler:handler]];
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:completedBlock];
    return alertController;
}

- (UIAlertController *)sw_presentTextFieldAlertWithAlertTitle:(NSString *)alertTitle alertMessgae:(NSString *)alertMessgae actionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray textFieldConfigurationHandler:(void(^)(UITextField *textField))configurationHandler handler:(void(^)(UIAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessgae preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:configurationHandler];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if(styleArray){
            style = (UIAlertActionStyle)styleArray[idx];
        }
        if(style < UIAlertActionStyleDefault || style > UIAlertActionStyleDestructive){
            style = UIAlertActionStyleDefault;
        }
        [alertController addAction:[UIAlertAction actionWithTitle:obj style:style handler:handler]];
    }];
    [self presentViewController:alertController animated:YES completion:completedBlock];
    return alertController;
}

- (void)sw_showAlertWithDestructiveActionTitle:(NSString *)destructiveTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:handler]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sw_showAlertWithDefaultActionTitle:(NSString *)actionTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:handler]];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:handler]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sw_showAlertWithActionTitles:(NSArray<NSString *> *)actionTitles title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alert addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:handler]];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sw_showAlertWithOnlyActionTitle:(NSString *)onlyActionTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler {
    [self sw_showAlertWithActionTitles:@[onlyActionTitle?:nil] title:title message:message handler:handler];
}

- (void)sw_showActionSheetWithTitle:(NSString *)title messgae:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles handler:(void(^)(UIAlertAction *action))handler {
    [self sw_showActionSheetWithTitle:title messgae:message actionTitles:actionTitles cancelTitle:@"取消" handler:handler];
}

- (void)sw_showActionSheetWithTitle:(NSString *)title messgae:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles cancelTitle:(NSString *)cancelTitle handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction:[UIAlertAction actionWithTitle:actionTitles[idx] style:UIAlertActionStyleDefault handler:handler]];
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)sw_showTextFieldAlertWithTitle:(NSString *)title message:(NSString *)message textFieldConfigurationHandler:(void(^)(UITextField *textField))configurationHandler actionInfo:(NSArray<NSDictionary *> *)actionInfo handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:configurationHandler];
    [actionInfo enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction:[UIAlertAction actionWithTitle:obj[kSWAlertActionTitle] style:[obj[kSWAlertActionStyle] integerValue] handler:handler]];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
