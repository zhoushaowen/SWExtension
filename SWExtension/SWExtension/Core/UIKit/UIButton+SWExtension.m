//
//  UIButton+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/8.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIButton+SWExtension.h"
#import "NSObject+SWMethodChange.h"
#import <objc/runtime.h>

static void* DisableAdjustImageWhenTouchDown_key = &DisableAdjustImageWhenTouchDown_key;

@implementation UIButton (SWExtension)

@dynamic sw_disableAdjustImageWhenTouchDown;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSel = @selector(setHighlighted:);
        SEL cusSel = @selector(sw_setHighlighted:);
        [self sw_exchangeMethodWithSystemSelector:sysSel customSelector:cusSel];
    });
}

- (void)sw_setHighlighted:(BOOL)highlighted {
    if(!self.sw_disableAdjustImageWhenTouchDown){
        [self sw_setHighlighted:highlighted];
    }
}

- (void)setSw_disableAdjustImageWhenTouchDown:(BOOL)sw_disableAdjustImageWhenTouchDown {
    objc_setAssociatedObject(self, DisableAdjustImageWhenTouchDown_key, @(sw_disableAdjustImageWhenTouchDown), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)sw_disableAdjustImageWhenTouchDown {
    return [objc_getAssociatedObject(self, DisableAdjustImageWhenTouchDown_key) boolValue];
}


@end
