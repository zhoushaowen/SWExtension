//
//  UIApplication+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/8/22.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SWExtension)

/**
 获取app版本号 (e.g. 1.0.0)
 */
@property (nonatomic,readonly,copy) NSString *sw_appVersion;
/**
 获取app的build版本号 (e.g. 1)
 */
@property (nonatomic,readonly,copy) NSString *sw_appBuildVersion;
/**
 获取app的target名称 (e.g. SWExtension)
 */
@property (nonatomic,readonly,copy) NSString *sw_appTargetName;
/**
 获取app的bundleID (e.g. com.yidu.SWExtension)
 */
@property (nonatomic,readonly,copy) NSString *sw_appBundleID;

/**
 获取当前显示在app最前面的viewController
 */
- (UIViewController *)sw_frontVC;

@end
