//
//  UIDevice+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/6/23.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIDevice+SWExtension.h"

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


@end
