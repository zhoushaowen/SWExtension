//
//  UIView+HUD.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)

- (MBProgressHUD *)showHUDAndHideWithDelay:(NSTimeInterval)delay
{
    [self hideHUDAnimated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    //去除高斯模糊效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;//bezelView是在backgroundView上的一个view
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    hud.backgroundView.backgroundColor = [UIColor clearColor];
    hud.backgroundColor = [UIColor clearColor];
    //设置文字颜色
    hud.contentColor = [UIColor whiteColor];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

- (MBProgressHUD *)showHUDAndHideWithDefaultDelay
{
    [self hideHUDAnimated:NO];
    MBProgressHUD *hud = [self showHUDAndHideWithDelay:0.25f];
    return hud;
}

- (MBProgressHUD *)showHUDWithMessage:(NSString *)message {
    return [self showHUDWithDetailMessage:message hideWithDelay:1];
}

- (MBProgressHUD *)showHUDWithMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [self showHUDAndHideWithDelay:delay];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    return hud;
}

- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message {
    return [self showHUDWithDetailMessage:message hideWithDelay:1];
}

- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [self showHUDAndHideWithDelay:delay];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    return hud;
}

- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView
{
    [self hideHUDAnimated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:NO];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.customView = customView;
    hud.square = YES;
    hud.bezelView.opaque = NO;
    hud.bezelView.layer.cornerRadius = 10;
    //设置边距
    hud.margin = 0;
    //去除高斯模糊效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    hud.backgroundView.backgroundColor = [UIColor clearColor];
    hud.backgroundColor = [UIColor clearColor];
    return hud;
}

- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [self showHUDWithCustomView:customView];
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

- (MBProgressHUD *)showHUD
{
    [self hideHUDAnimated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    //去除高斯模糊效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;//bezelView是在backgroundView上的一个view
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    hud.backgroundView.backgroundColor = [UIColor clearColor];
    hud.backgroundColor = [UIColor clearColor];
    //设置内容颜色
    hud.contentColor = [UIColor whiteColor];
    return hud;
}

- (BOOL)hideHUDAnimated:(BOOL)animated
{
    return [MBProgressHUD hideHUDForView:self animated:animated];
}


@end
