//
//  UIView+SWHUD.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIView+SWHUD.h"

@implementation UIView (SWHUD)

- (MBProgressHUD *)sw_createAndShowHUDWithAnimationType:(MBProgressHUDAnimation)animationType
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.animationType = animationType;
    hud.removeFromSuperViewOnHide = YES;
    [self addSubview:hud];
    [hud showAnimated:YES];
    return hud;
}

- (MBProgressHUD *)sw_showHUDAndHideWithDelay:(NSTimeInterval)delay
{
    [self sw_hideHUDAnimated:NO];
    MBProgressHUD *hud = [self sw_createAndShowHUDWithAnimationType:MBProgressHUDAnimationZoomIn];
    //去除高斯模糊效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;//bezelView是在backgroundView上的一个view
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    hud.backgroundView.backgroundColor = [UIColor clearColor];
    hud.backgroundColor = [UIColor clearColor];
    //设置文字颜色
    hud.contentColor = [UIColor whiteColor];
    //设置文字内边距
    hud.margin = 8;
    hud.animationType = MBProgressHUDAnimationFade;
    if(delay > 0){
        [hud hideAnimated:YES afterDelay:delay];
    }
    return hud;
}

- (MBProgressHUD *)sw_showHUDWithMessage:(NSString *)message {
    return [self sw_showHUDWithMessage:message hideWithDelay:-1];
}

- (MBProgressHUD *)sw_showHUDWithMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay {
    if(message.length < 1) return nil;
    MBProgressHUD *hud = [self sw_showHUDAndHideWithDelay:delay];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    return hud;
}


- (MBProgressHUD *)sw_showHUDWithCustomView:(UIView *)customView {
    [self sw_hideHUDAnimated:NO];
    MBProgressHUD *hud = [self sw_createAndShowHUDWithAnimationType:MBProgressHUDAnimationZoomIn];
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

- (MBProgressHUD *)sw_showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [self sw_showHUDWithCustomView:customView];
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

- (MBProgressHUD *)sw_showHUD {
    [self sw_hideHUDAnimated:NO];
    MBProgressHUD *hud = [self sw_createAndShowHUDWithAnimationType:MBProgressHUDAnimationFade];
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

- (MBProgressHUD *)sw_showHUDWithBottomText:(NSString *)bottomText {
    MBProgressHUD *hud = [self sw_showHUD];
    hud.detailsLabel.text = bottomText;
    return hud;
}

- (BOOL)sw_hideHUDAnimated:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    hud.animationType = MBProgressHUDAnimationFade;
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:animated];
        return YES;
    }
    return NO;
}


#pragma mark - deprecated
- (MBProgressHUD *)showHUDWithMessage:(NSString *)message __deprecated {
    return [self showHUDWithMessage:message hideWithDelay:-1];
}

- (MBProgressHUD *)showHUDWithMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay __deprecated {
    if(message.length < 1) return nil;
    MBProgressHUD *hud = [self sw_showHUDAndHideWithDelay:delay];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.font = [UIFont boldSystemFontOfSize:15];
    return hud;
}

- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message __deprecated {
    return [self showHUDWithDetailMessage:message hideWithDelay:-1];
}

- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay __deprecated {
    return [self sw_showHUDWithMessage:message hideWithDelay:delay];
}

- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView __deprecated
{
    return [self sw_showHUDWithCustomView:customView];
}

- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay __deprecated
{
    return [self sw_showHUDWithCustomView:customView hideWithDelay:delay];
}

- (MBProgressHUD *)showHUD __deprecated
{
    return [self sw_showHUD];
}

- (MBProgressHUD *)showHUDWithBottomText:(NSString *)bottomText __deprecated{
    return [self sw_showHUDWithBottomText:bottomText];
}

- (BOOL)hideHUDAnimated:(BOOL)animated __deprecated
{
    return [self sw_hideHUDAnimated:animated];
}


@end
