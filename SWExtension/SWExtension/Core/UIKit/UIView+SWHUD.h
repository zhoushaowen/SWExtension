//
//  UIView+SWHUD.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UIView (SWHUD)
/**
 显示一个可以自动换行的文字提示类型的MBProgressHUD,不会自动隐藏

 @param message 文字内容
 @return MBProgressHUD
 */
- (MBProgressHUD *)sw_showHUDWithMessage:(NSString *)message;
- (MBProgressHUD *)showHUDWithMessage:(NSString *)message __deprecated_msg("Use 'sw_showHUDWithMessage:'");

/**
 显示一个可以自动换行的文字提示类型的MBProgressHUD，自定义多少秒之后隐藏

 @param message 文字内容
 @param delay 多少秒之后隐藏,如果delay<0，那么表示不会自动隐藏
 @return MBProgressHUD
 */
- (MBProgressHUD *)sw_showHUDWithMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay;
- (MBProgressHUD *)showHUDWithMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay __deprecated_msg("Use 'sw_showHUDWithMessage:hideWithDelay:'");

/**
 显示一个可以自动换行的文字提示MBProgressHUD，不会自动隐藏

 @param message 文字内容
 @return MBProgressHUD
 */
- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message __deprecated_msg("Use 'sw_showHUDWithMessage:'");

/**
显示一个可以自动换行的文字提示MBProgressHUD，自定义多少秒之后隐藏

 @param message 文字内容
 @param delay 多少秒之后隐藏,如果delay<0，那么表示不会自动隐藏
 @return MBProgressHUD
 */
- (MBProgressHUD *)showHUDWithDetailMessage:(NSString *)message hideWithDelay:(NSTimeInterval)delay __deprecated_msg("Use 'sw_showHUDWithMessage:hideWithDelay:'");

/**
 显示一个自定义的MBProgressHUD，不会自动隐藏

 @param customView 自定义的view
 @return MBProgressHUD
 */
- (MBProgressHUD *)sw_showHUDWithCustomView:(UIView *)customView;
- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView __deprecated_msg("Use 'sw_showHUDWithCustomView:'");


/**
 显示一个自定义的MBProgressHUD，自定义多少秒之后自动隐藏

 @param customView 自定义的view
 @param delay 多少秒之后隐藏,如果delay<0，那么表示不会自动隐藏
 @return MBProgressHUD
 */
- (MBProgressHUD *)sw_showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay;
- (MBProgressHUD *)showHUDWithCustomView:(UIView *)customView hideWithDelay:(NSTimeInterval)delay __deprecated_msg("Use 'sw_showHUDWithCustomView:hideWithDelay:'");

/**
 显示一个等待的指示器类型的MBProgressHUD，不会自动隐藏

 @return 返回该MBProgressHUD
 */
- (MBProgressHUD *)sw_showHUD;
- (MBProgressHUD *)showHUD __deprecated_msg("Use 'sw_showHUD'");

/**
 显示可以指定底部文字的菊花指示器类型的MBProgressHUD，不会自动隐藏

 @param bottomText 底部文字
 @return MBProgressHUD
 */
- (MBProgressHUD *)sw_showHUDWithBottomText:(NSString *)bottomText;
- (MBProgressHUD *)showHUDWithBottomText:(NSString *)bottomText __deprecated_msg("Use 'sw_showHUDWithBottomText:'");

/**
 隐藏一个MBProgressHUD

 @param animated 是否以动画形式结束
 @return 是否成功隐藏
 */
- (BOOL)sw_hideHUDAnimated:(BOOL)animated;
- (BOOL)hideHUDAnimated:(BOOL)animated __deprecated_msg("Use 'sw_hideHUDAnimated:'");


@end
