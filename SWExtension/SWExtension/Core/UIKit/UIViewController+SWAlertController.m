//
//  UIViewController+SWAlertController.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIViewController+SWAlertController.h"

@interface SWAlertAction ()

@property (nonatomic) NSInteger index;

@end

@implementation SWAlertAction

@end

NSString *const kSWAlertActionStyle = @"kSWAlertActionStyle";
NSString *const kSWAlertActionTitle = @"kSWAlertActionTitle";

@implementation UIViewController (SWAlertController)

- (UIAlertController *)sw_presentAlertControllerWithStyle:(UIAlertControllerStyle)controllerStyle
                                                    attributedTitle:(NSAttributedString *)attributedTitle
                                                  attributedMessage:(NSAttributedString *)attributedMessage actionTitles:(NSArray<NSString *> *)actionTitles
                                                        actionStyles:(NSArray<NSNumber *> *)actionStyles
                                                   actionTitleColors:(NSArray<UIColor *> *)actionTitleColors
                                                            handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:controllerStyle];
    [alert setValue:attributedTitle forKey:@"attributedTitle"];
    [alert setValue:attributedMessage forKey:@"attributedMessage"];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SWAlertAction *action = [SWAlertAction actionWithTitle:obj style:actionStyles.count > idx? [actionStyles[idx] integerValue]:UIAlertActionStyleDefault handler:(void(^)(UIAlertAction *action))handler];
        if(actionTitleColors.count > idx){
            UIColor *actionTitleColor = actionTitleColors[idx];
            if([actionTitleColor isKindOfClass:[UIColor class]]){
                [action setValue:actionTitleColor forKey:@"titleTextColor"];                
            }
        }
        action.index = idx;
        [alert addAction:action];
    }];
    [self presentViewController:alert animated:YES completion:completedBlock];
    return alert;
}

- (UIAlertController *)sw_presentAlertWithAttributedTitle:(NSAttributedString *)attributedTitle
                                                  attributedMessage:(NSAttributedString *)attributedMessage actionTitles:(NSArray<NSString *> *)actionTitles
                                                        actionStyles:(NSArray<NSNumber *> *)actionStyles
                                                   actionTitleColors:(NSArray<UIColor *> *)actionTitleColors
                                                            handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    return [self sw_presentAlertControllerWithStyle:UIAlertControllerStyleAlert attributedTitle:attributedTitle attributedMessage:attributedMessage actionTitles:actionTitles actionStyles:actionStyles actionTitleColors:actionTitleColors handler:handler completion:completedBlock];
}

- (UIAlertController *)sw_presentAlertWithTitle:(NSString *)title
                                                  message:(NSString *)message
                                     titleColor:(UIColor *)titleColor
                                     messageColor:(UIColor *)messageColor
                                   actionTitles:(NSArray<NSString *> *)actionTitles
                                                        actionStyles:(NSArray<NSNumber *> *)actionStyles
                                                   actionTitleColors:(NSArray<UIColor *> *)actionTitleColors
                                                            handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    return [self sw_presentAlertControllerWithStyle:UIAlertControllerStyleAlert attributedTitle:[[NSAttributedString alloc] initWithString:title?:@"" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:titleColor?:[UIColor blackColor]}]
                                  attributedMessage:[[NSAttributedString alloc] initWithString:message?:@"" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:messageColor?:[UIColor blackColor]}]
                                       actionTitles:actionTitles
                                       actionStyles:actionStyles actionTitleColors:actionTitleColors
                                            handler:handler
                                         completion:completedBlock];
}

- (UIAlertController *)sw_presentActionSheetWithAttributedTitle:(NSAttributedString *)attributedTitle
                                                  attributedMessage:(NSAttributedString *)attributedMessage actionTitles:(NSArray<NSString *> *)actionTitles
                                                        actionStyles:(NSArray<NSNumber *> *)actionStyles
                                                   actionTitleColors:(NSArray<UIColor *> *)actionTitleColors
                                                            handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    return [self sw_presentAlertControllerWithStyle:UIAlertControllerStyleActionSheet attributedTitle:attributedTitle attributedMessage:attributedMessage actionTitles:actionTitles actionStyles:actionStyles actionTitleColors:actionTitleColors handler:handler completion:completedBlock];
}

- (UIAlertController *)sw_presentActionSheetWithTitle:(NSString *)title
                                                  message:(NSString *)message defaultActionTitles:(NSArray<NSString *> *)defaultActionTitles
                                                        cancelActionTitle:(NSString *)cancelActionTitle
                                                   defaultActionTitleColor:(UIColor *)defaultActionTitleColor
                                                   cancelActionTitleColor:(UIColor *)cancelActionTitleColor
                                                            handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    NSMutableArray *actionTitles = [NSMutableArray arrayWithArray:defaultActionTitles?:@[]];
    [actionTitles addObject:cancelActionTitle];
    NSMutableArray *actionStyles = [NSMutableArray arrayWithCapacity:defaultActionTitles.count + 1];
    NSMutableArray *actionTitleColors = [NSMutableArray arrayWithCapacity:defaultActionTitles.count + 1];
    [defaultActionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [actionStyles addObject:@(UIAlertActionStyleDefault)];
        [actionTitleColors addObject:defaultActionTitleColor?:[NSObject new]];
    }];
    [actionTitleColors addObject:cancelActionTitleColor?:[NSObject new]];
    [actionStyles addObject:@(UIAlertActionStyleCancel)];
    return [self sw_presentAlertControllerWithStyle:UIAlertControllerStyleActionSheet attributedTitle:[[NSAttributedString alloc] initWithString:title?:@"" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}] attributedMessage:[[NSAttributedString alloc] initWithString:message?:@"" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}] actionTitles:[actionTitles copy] actionStyles:[actionStyles copy] actionTitleColors:[actionTitleColors copy] handler:handler completion:completedBlock];
}

- (UIAlertController *)sw_presentAlertWithDestructiveActionTitle:(NSString *)destructiveTitle cancelActionTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    SWAlertAction *action0 = [SWAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    action0.index = 0;
    [alert addAction:action0];
    SWAlertAction *action1 = [SWAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:(void(^)(UIAlertAction *action))handler];
    action1.index = 1;
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:completedBlock];
    return alert;
}

- (UIAlertController *)sw_presentAlertWithDefaultActionTitle:(NSString *)defaultTitle cancelActionTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    SWAlertAction *action0 = [SWAlertAction actionWithTitle:defaultTitle style:UIAlertActionStyleDefault handler:(void(^)(UIAlertAction *action))handler];
    action0.index = 0;
    SWAlertAction *action1 = [SWAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:(void(^)(UIAlertAction *action))handler];
    action1.index = 1;
    [alert addAction:action0];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:completedBlock];
    return alert;
}

- (UIAlertController *)sw_presentAlertWithActionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if(styleArray){
            style = (UIAlertActionStyle)styleArray[idx];
        }
        if(style < UIAlertActionStyleDefault || style > UIAlertActionStyleDestructive){
            style = UIAlertActionStyleDefault;
        }
        SWAlertAction *action = [SWAlertAction actionWithTitle:obj style:style handler:(void(^)(UIAlertAction *action))handler];
        action.index = idx;
        [alert addAction:action];
    }];
    [self presentViewController:alert animated:YES completion:completedBlock];
    return alert;
}

- (UIAlertController *)sw_presentAlertWithOnlyActionTitle:(NSString *)onlyActionTitle style:(UIAlertActionStyle)style alertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertActionStyle arr[1] = {style};
    return [self sw_presentAlertWithActionTitles:@[onlyActionTitle] styleArray:arr alertTitle:alertTitle alertMessage:alertMessage handler:handler completion:completedBlock];
}

- (UIAlertController *)sw_presentActionSheetWithSheetTitle:(NSString *)sheetTitle sheetMessgae:(NSString *)sheetMessgae actionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray cancelActionTitle:(NSString *)cancelTitle handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sheetTitle message:sheetMessgae preferredStyle:UIAlertControllerStyleActionSheet];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if(styleArray){
            style = (UIAlertActionStyle)styleArray[idx];
        }
        if(style < UIAlertActionStyleDefault || style > UIAlertActionStyleDestructive){
            style = UIAlertActionStyleDefault;
        }
        SWAlertAction *action = [SWAlertAction actionWithTitle:actionTitles[idx] style:style handler:(void(^)(UIAlertAction *action))handler];
        action.index = idx;
        [alertController addAction:action];
    }];
    SWAlertAction *action = [SWAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    action.index = actionTitles.count;
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:completedBlock];
    return alertController;
}

- (UIAlertController *)sw_presentTextFieldAlertWithAlertTitle:(NSString *)alertTitle alertMessgae:(NSString *)alertMessgae actionTitles:(NSArray<NSString *> *)actionTitles styleArray:(UIAlertActionStyle *)styleArray textFieldConfigurationHandler:(void(^)(UITextField *textField))configurationHandler handler:(void(^)(SWAlertAction *action))handler completion:(void(^)(void))completedBlock {
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
        SWAlertAction *action = [SWAlertAction actionWithTitle:obj style:style handler:(void(^)(UIAlertAction *action))handler];
        action.index = idx;
        [alertController addAction:action];
    }];
    [self presentViewController:alertController animated:YES completion:completedBlock];
    return alertController;
}

#pragma mark - deprecated
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
