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

/**
 显示一个文字提示,默认一秒之后自动隐藏

 @param message 要显示的文字
 @return 返回该MBProgressHUD
 */
- (MBProgressHUD *)showHUDWithMessage:(NSString *)message;
- (MBProgressHUD *)showHUDWithMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay ;
- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView;
- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay;

/**
 显示一个等待的指示器

 @return 返回该MBProgressHUD
 */
- (MBProgressHUD *)showHUD;
- (BOOL)hideHUDAnimated:(BOOL)animated;

@end
