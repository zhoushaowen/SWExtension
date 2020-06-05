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

@end
