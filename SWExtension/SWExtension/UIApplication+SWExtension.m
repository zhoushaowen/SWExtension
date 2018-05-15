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

- (UIViewController *)sw_frontVC {
    return [self _sw_frontVC:[self delegate].window.rootViewController];
}

- (UIViewController *)_sw_frontVC:(UIViewController *)vc {
    if(vc.presentedViewController){
        return [self _sw_frontVC:vc.presentedViewController];
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        return [self _sw_frontVC:((UINavigationController *)vc).visibleViewController];
    }else if ([self isKindOfClass:[UITabBarController class]]){
        return [self _sw_frontVC:((UITabBarController *)vc).selectedViewController];
    }else{
        NSInteger count = vc.childViewControllers.count;
        for (NSInteger i=count -1; i>=0; i--) {
            UIViewController *childVC = vc.childViewControllers[count];
            if(childVC && childVC.isViewLoaded && childVC.view.window){
                vc = [self _sw_frontVC:childVC];
                break;
            }
        }
        return vc;
    }
}

@end
