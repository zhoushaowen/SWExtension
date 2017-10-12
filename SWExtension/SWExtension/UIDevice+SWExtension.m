//
//  UIDevice+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/6/23.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIDevice+SWExtension.h"
#import "sys/sysctl.h"

@implementation UIDevice (SWExtension)

+ (BOOL)sw_isSpecifiedIOSOrLater:(NSString *)specifiedIOSVersion {
    return [[[UIDevice currentDevice] systemVersion] compare:specifiedIOSVersion options:NSNumericSearch] != NSOrderedAscending;
}

+ (BOOL)sw_isIOS7OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"7.0"];
    });
    return flag;
}

+ (BOOL)sw_isIOS8OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"8.0"];
    });
    return flag;
}


+ (BOOL)sw_isIOS9OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"9.0"];
    });
    return flag;
}


+ (BOOL)sw_isIOS10OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"10.0"];
    });
    return flag;
}

+ (BOOL)sw_isIOS11OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"11.0"];
    });
    return flag;
}

+ (BOOL)sw_isIPhoneX {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812) {
            flag = YES;
        }
    });
    return flag;
}

+ (CGFloat)sw_navigationBarHeight {
    if([self sw_isIPhoneX]) return 88;
    return 64;
}

+ (CGFloat)sw_tabBarHeight {
    if([self sw_isIPhoneX]) return 83;
    return 49;
}

+ (CGFloat)sw_statusBarHeight {
    if([self sw_isIPhoneX]) return 44;
    return 20;
}

- (NSString *)sw_deviceString {
    static NSString *name;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        name = [[self sw_getDeviceName] copy];
    });
    return name;
}

#pragma mark - Private
- (NSString *)sw_getDeviceName {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";

    
    //iPod
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (32nm)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini 1 (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad mini 1 (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad mini 1 (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (4G)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (4G)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro (9.7 inch)";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro (9.7 inch)";
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro (12.9 inch)";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro (12.9 inch)";
    
    //Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])   return @"Apple Watch 38mm";
    if ([platform isEqualToString:@"Watch1,2"])   return @"Apple Watch 42mm";
    if ([platform isEqualToString:@"Watch2,3"])   return @"Apple Watch Series 2 38mm";
    if ([platform isEqualToString:@"Watch2,4"])   return @"Apple Watch Series 2 42mm";
    if ([platform isEqualToString:@"Watch2,6"])   return @"Apple Watch Series 1 38mm";
    if ([platform isEqualToString:@"Watch2,7"])   return @"Apple Watch Series 1 42mm";
    
    //Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"])  return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"])  return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])  return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"])  return @"Apple TV 4";
    
    
    //Simulator
    if ([platform isEqualToString:@"i386"])    return @"iPhone Simulator x86";
    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator x64";
    
    return platform;
}





@end
