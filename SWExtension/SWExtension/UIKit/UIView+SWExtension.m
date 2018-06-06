//
//  UIView+SWExtension.m
//  test
//
//  Created by zhoushaowen on 2018/6/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "UIView+SWExtension.h"

@implementation UIView (SWExtension)

- (__kindof UIViewController *_Nullable)sw_viewController {
    if([self.nextResponder isKindOfClass:[UIViewController class]]){
        return (UIViewController *)self.nextResponder;
    }
    if(self.superview){
        return [self.superview sw_viewController];
    }
    return nil;
}

@end
