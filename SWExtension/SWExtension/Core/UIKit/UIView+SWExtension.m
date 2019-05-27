//
//  UIView+SWExtension.m
//  test
//
//  Created by zhoushaowen on 2018/6/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "UIView+SWExtension.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,strong) SWGestureActionBlock sw_gestureActionBlock;

@end

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

- (void)setSw_gestureActionBlock:(SWGestureActionBlock)sw_gestureActionBlock {
    objc_setAssociatedObject(self, @selector(sw_gestureActionBlock), sw_gestureActionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SWGestureActionBlock)sw_gestureActionBlock {
    return objc_getAssociatedObject(self, @selector(sw_gestureActionBlock));
}

- (void)sw_addGestureRecognizerWithClass:(Class)gestureRecognizerClass delegate:(id<UIGestureRecognizerDelegate> _Nullable)delegate actionBlock:(SWGestureActionBlock)gestureActionBlock {
    NSAssert([gestureRecognizerClass instancesRespondToSelector:@selector(initWithTarget:action:)], @"必须是UIGestureRecognizer类");
    UIGestureRecognizer *gesture = [[gestureRecognizerClass alloc] initWithTarget:self action:@selector(sw_handleGesture:)];
    gesture.delegate = delegate;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gesture];
    self.sw_gestureActionBlock = gestureActionBlock;
}

- (void)sw_addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withActionBlock:(SWGestureActionBlock)gestureActionBlock {
    NSAssert([gestureRecognizer isKindOfClass:[UIGestureRecognizer class]], @"必须是UIGestureRecognizer类");
    [gestureRecognizer addTarget:self action:@selector(sw_handleGesture:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gestureRecognizer];
    self.sw_gestureActionBlock = gestureActionBlock;
}


- (void)sw_handleGesture:(UITapGestureRecognizer *)gesture {
    if(self.sw_gestureActionBlock){
        self.sw_gestureActionBlock(gesture);
    }
}


@end
