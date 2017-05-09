//
//  UIViewController+SWAlertController.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIViewController+SWAlertController.h"

@implementation UIViewController (SWAlertController)

- (void)sw_showAlertWithDestructiveActionTitle:(NSString *)destructiveTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:handler]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sw_showAlertWithDefaultActionTitle:(NSString *)actionTitle title:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
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

- (void)sw_showActionSheetWithActionTitles:(NSArray<NSString *> *)actionTitles handler:(void(^)(UIAlertAction *action))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction:[UIAlertAction actionWithTitle:actionTitles[idx] style:UIAlertActionStyleDefault handler:handler]];
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
