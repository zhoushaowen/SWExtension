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
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:NO afterDelay:delay];
    
    return hud;
}

- (MBProgressHUD *)showHUDAndHideWithDefaultDelay
{
    [self hideHUDAnimated:NO];
    MBProgressHUD *hud = [self showHUDAndHideWithDelay:0.25f];
    return hud;
}

- (MBProgressHUD *)showHUDAndHideWithDefaultDelayWithMessage:(NSString *)message {
    MBProgressHUD *hud = [self showHUDAndHideWithDelay:1];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    return hud;
}

- (MBProgressHUD *)showHUDAndHideWithDelay:(NSTimeInterval)delay withMessage:(NSString *)message {
    MBProgressHUD *hud = [self showHUDAndHideWithDelay:delay];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
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
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;//backgroundView是在bezelView上的一个view
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
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
    return hud;
}

- (BOOL)hideHUDAnimated:(BOOL)animated
{
    return [MBProgressHUD hideHUDForView:self animated:animated];
}


@end
