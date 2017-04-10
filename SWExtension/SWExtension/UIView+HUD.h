//
//  UIView+HUD.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (HUD)

- (MBProgressHUD *)showHUDAndHideWithDelay:(NSTimeInterval)delay;
- (MBProgressHUD *)showHUDAndHideWithDefaultDelay;
- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView;
- (void)showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay;
- (MBProgressHUD *)showHUD;
- (BOOL)hideHUDAnimated:(BOOL)animated;

@end
