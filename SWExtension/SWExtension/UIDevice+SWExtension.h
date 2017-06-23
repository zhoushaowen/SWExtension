//
//  UIDevice+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/6/23.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

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
 是否是指定的iOS版本或者更高版本
 */
+ (BOOL)sw_isSpecifiedIOSOrLater:(NSString *)specifiedIOSVersion;


@end





