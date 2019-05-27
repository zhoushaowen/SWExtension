//
//  UIView+ExpandResponse.m
//  ExpandResponse
//
//  Created by 周少文 on 2016/11/18.
//  Copyright © 2016年 Yidu. All rights reserved.
//

#import "UIView+ExpandResponse.h"
#import <objc/runtime.h>

static void *expandResponseKey = &expandResponseKey;

@implementation UIView (ExpandResponse)

@dynamic expandResponse;

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSel = @selector(pointInside:withEvent:);
        SEL cusSel = @selector(sw_pointInside:withEvent:);
        Method method1 = class_getInstanceMethod([self class], sysSel);
        Method method2 = class_getInstanceMethod([self class], cusSel);
        if(class_addMethod([self class], sysSel, method_getImplementation(method2), method_getTypeEncoding(method2))){
            class_replaceMethod([self class], cusSel, method_getImplementation(method1), method_getTypeEncoding(method1));
        }else{
            method_exchangeImplementations(method1, method2);
        }
    });
}

- (BOOL)sw_pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.expandResponse)
    {
        CGRect bounds = self.bounds;
        CGFloat dx = MIN(bounds.size.width - 44.0f, 0)/2.0f;
        CGFloat dy = MIN(bounds.size.height - 44.0f, 0)/2.0f;
        bounds = CGRectInset(bounds, dx, dy);
        return CGRectContainsPoint(bounds, point);
    }else{
        return [self sw_pointInside:point withEvent:event];
    }
}

- (void)setExpandResponse:(BOOL)expandResponse
{
    objc_setAssociatedObject(self, expandResponseKey, @(expandResponse), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)expandResponse
{
    return [objc_getAssociatedObject(self, expandResponseKey) boolValue];
}


@end
