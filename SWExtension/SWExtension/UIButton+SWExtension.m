//
//  UIButton+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/8.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIButton+SWExtension.h"
#import <objc/runtime.h>

static void* DisableAdjustImageWhenTouchDown_key = &DisableAdjustImageWhenTouchDown_key;

@implementation UIButton (SWExtension)

@dynamic sw_disableAdjustImageWhenTouchDown;

+ (void)load {
    Method systemMethod = class_getInstanceMethod([self class], @selector(setHighlighted:));
    Method customMethod = class_getInstanceMethod([self class], @selector(sw_setHighlighted:));
    method_exchangeImplementations(systemMethod, customMethod);
}

- (void)sw_setHighlighted:(BOOL)highlighted {
    if(!self.sw_disableHightedImageWhenTouchDown){
        [self sw_setHighlighted:highlighted];
    }
}

- (void)setSw_disableHightedImageWhenTouchDown:(BOOL)sw_disableHightedImageWhenTouchDown {
    objc_setAssociatedObject(self, DisableAdjustImageWhenTouchDown_key, @(sw_disableHightedImageWhenTouchDown), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)sw_disableHightedImageWhenTouchDown {
    return [objc_getAssociatedObject(self, DisableAdjustImageWhenTouchDown_key) boolValue];
}

@end
