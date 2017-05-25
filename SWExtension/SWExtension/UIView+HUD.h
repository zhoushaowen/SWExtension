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
 显示一个文字提示,一秒之后自动隐藏

 @param message 文字内容
 @return MBProgressHUD
 */
- (MBProgressHUD *)showHUDWithMessage:(NSString *)message;

/**
 显示一个文字提示，自定义多少秒之后隐藏

 @param message 文字内容
 @param delay 多少秒之后隐藏
 @return MBProgressHUD
 */
- (MBProgressHUD *)showHUDWithMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay;

/**
 显示一个可以换行的文字提示，一秒之后自动隐藏

 @param message 文字内容
 @return MBProgressHUD
 */
- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message;

/**
 显示一个可以换行的文字提示，自定义多少秒之后隐藏

 @param message 文字内容
 @param delay 多少秒之后隐藏
 @return MBProgressHUD
 */
- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay;
- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView;
- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay;

/**
 显示一个等待的指示器

 @return 返回该MBProgressHUD
 */
- (MBProgressHUD *)showHUD;
- (BOOL)hideHUDAnimated:(BOOL)animated;

@end
