//
//  UIDevice+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/6/23.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SWDeviceModelType) {
    SWDeviceModelTypeNormal,//普通屏幕手机
    SWDeviceModelTypeIPhoneX,//iPhone X
    SWDeviceModelTypeIPhoneXR,//iPhone XR
    SWDeviceModelTypeIPhoneXS = SWDeviceModelTypeIPhoneX,////分辨率一样
    SWDeviceModelTypeIPhoneXSMax,//iPhone XS Max
    SWDeviceModelTypeIPhone11 = SWDeviceModelTypeIPhoneXR,//分辨率一样
    SWDeviceModelTypeIPhone11Pro = SWDeviceModelTypeIPhoneX,//分辨率一样
    SWDeviceModelTypeIPhone11ProMax = SWDeviceModelTypeIPhoneXSMax,//分辨率一样
    SWDeviceModelTypeIPhone12Mini,
    SWDeviceModelTypeIPhone12,
    SWDeviceModelTypeIPhone12Pro = SWDeviceModelTypeIPhone12,
    SWDeviceModelTypeIPhone12ProMax,
};

@interface UIDevice (SWExtension)


/**
 是否是iOS7或者更高版本
 */
+ (BOOL)sw_isIOS7OrLater;
/**
 是否是iOS8或者更高版本
 */
+ (BOOL)sw_isIOS8OrLater;
/**
 是否是iOS9或者更高版本
 */
+ (BOOL)sw_isIOS9OrLater;
/**
 是否是iOS10或者更高版本
 */
+ (BOOL)sw_isIOS10OrLater;
/**
 是否是iOS11或者更高版本
 */
+ (BOOL)sw_isIOS11OrLater;
/**
 是否是指定的iOS版本或者更高版本 (e.g. 11.0)
 */
+ (BOOL)sw_isSpecifiedIOSOrLater:(NSString *)specifiedIOSVersion;

/// 获取UIWindow的safeAreaInsets
+ (UIEdgeInsets)sw_safeAreaInsets;

/**
 是否是iPhone X
 */
+ (BOOL)sw_isIPhoneX __deprecated_msg("Use 'sw_isIPhoneXSeries'");

/**
 是否是iPhone X系列(包含X、XR、XS、XS Max等刘海屏机型)
 */
+ (BOOL)sw_isIPhoneXSeries __deprecated_msg("Use 'sw_isNormalScreen'");

//是否是普通屏幕手机 否则是刘海屏
+ (BOOL)sw_isNormalScreen;

+ (SWDeviceModelType)sw_deviceModelType __deprecated;

/**
 导航高度(包含状态栏的高度)
 */
+ (CGFloat)sw_navigationBarHeight;
/**
 tabbar高度(包括距离底部的安全距离)
 */
+ (CGFloat)sw_tabBarHeight;
/**
 状态栏高度, statusBar隐藏的时候高度为0
 */
+ (CGFloat)sw_statusBarHeight;
/**
 竖屏的情况下距离屏幕顶部的安全距离
 */
+ (CGFloat)sw_safeTopInset;
/**
 竖屏的情况下距离屏幕底部的安全距离
 */
+ (CGFloat)sw_safeBottomInset;
///获取udid,注意:每次获取到的值都不一样,需要开发者主动去存储起来
+ (NSString *)sw_getUUID;
/// 获取当前设备名称（e.g. iPhone 4s）
+ (NSString *)sw_deviceString;


/**
 获取当前设备名称（e.g. iPhone 4s）
 */
@property (nonatomic,readonly,copy) NSString *sw_deviceString __deprecated;


@end





