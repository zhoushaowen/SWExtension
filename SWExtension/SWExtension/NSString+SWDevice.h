//
//  NSString+SWDevice.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/11.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SWDevice)

/**
 获取设备具体型号，如：iPhone4s

 @return 设备型号
 */
+ (NSString*)sw_deviceString;

/**
 获取app版本号

 @return 版本号
 */
+ (NSString *)sw_appVersion;

@end
