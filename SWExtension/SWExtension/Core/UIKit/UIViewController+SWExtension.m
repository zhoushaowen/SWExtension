//
//  UIViewController+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/6/5.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "UIViewController+SWExtension.h"

@implementation UIViewController (SWExtension)

- (UINavigationController *_Nullable)sw_presentingNavigationController {
    UIViewController *presentingVc = self.presentingViewController;
    UINavigationController *nav = nil;
    if([presentingVc isKindOfClass:[UITabBarController class]]){
        UIViewController *selectedVc = ((UITabBarController *)presentingVc).selectedViewController;
        nav = [selectedVc isKindOfClass:[UINavigationController class]]?(UINavigationController *)selectedVc:nil;
    }else if ([presentingVc isKindOfClass:[UINavigationController class]]){
        nav = (UINavigationController *)presentingVc;
    }else{
        nav = presentingVc.navigationController;
    }
    return nav;
}

- (SWExtensionControllerShouldBackType)sw_viewControllerShouldBackType {
    UIViewController *presentedViewController = self.presentingViewController.presentedViewController;
    if(self.presentingViewController && presentedViewController){
        if(presentedViewController == self){
            return SWExtensionControllerShouldBackTypeDismiss;
        }
        else if (presentedViewController == self.navigationController){
            UINavigationController *nav = (UINavigationController *)presentedViewController;
            if(nav.viewControllers.count > 1){
                return SWExtensionControllerShouldBackTypePop;
            }
            return SWExtensionControllerShouldBackTypeDismiss;
        }
        else if (presentedViewController == self.tabBarController){
            UITabBarController *tabbar = (UITabBarController *)presentedViewController;
            UINavigationController *nav = (UINavigationController *)tabbar.selectedViewController;
            if([nav isKindOfClass:[UINavigationController class]] && nav.viewControllers.count > 1){
                return SWExtensionControllerShouldBackTypePop;
            }
            return SWExtensionControllerShouldBackTypeDismiss;
        }
    }
    if(self.navigationController && self.navigationController.viewControllers.count > 1){
        return SWExtensionControllerShouldBackTypePop;
    }
    return SWExtensionControllerShouldBackTypeUnknown;
}

+ (instancetype)sw_topViewController {
    UIViewController *rootVc = [UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootVc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabbar = (UITabBarController *)rootVc;
        UIViewController *selectedVc = tabbar.selectedViewController;
        return [selectedVc __sw_topViewController];
    }
    else if ([rootVc isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)rootVc;
        UIViewController *visbleVc = nav.visibleViewController;
        return [visbleVc __sw_topViewController];
    }
    else{
        return [rootVc __sw_topViewController];
    }
}

- (instancetype)__sw_topViewController {
    if(self.presentedViewController){
        return [self.presentedViewController __sw_topViewController];
    }else{
        return self;
    }
}

@end
