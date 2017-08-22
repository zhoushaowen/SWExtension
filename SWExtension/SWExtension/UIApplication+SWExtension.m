//
//  UIApplication+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/8/22.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIApplication+SWExtension.h"

@implementation UIApplication (SWExtension)

- (NSString *)sw_appVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)sw_appBuildVersion {
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
}

- (NSString *)sw_appTargetName {
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleExecutable"];
}

- (NSString *)sw_appBundleID {
    return [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"];
}

@end
