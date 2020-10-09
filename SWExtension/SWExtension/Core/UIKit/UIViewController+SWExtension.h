//
//  UIViewController+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2020/6/5.
//  Copyright © 2020 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SWExtensionControllerShouldBackType) {
    SWExtensionControllerShouldBackTypeUnknown,
    SWExtensionControllerShouldBackTypeDismiss,
    SWExtensionControllerShouldBackTypePop,
};

@interface UIViewController (SWExtension)

- (UINavigationController *_Nullable)sw_presentingNavigationController;

- (SWExtensionControllerShouldBackType)sw_viewControllerShouldBackType;

+ (instancetype)sw_topViewController;

@end

NS_ASSUME_NONNULL_END
