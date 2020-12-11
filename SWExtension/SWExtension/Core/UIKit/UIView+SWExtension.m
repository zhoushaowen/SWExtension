//
//  UIView+SWExtension.m
//  test
//
//  Created by zhoushaowen on 2018/6/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "UIView+SWExtension.h"
#import <objc/runtime.h>

@interface SWGestureViewDelegate : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic,strong) BOOL(^gestureRecognizerShouldReceiveTouch)(UIGestureRecognizer *ges,UITouch *touch);

@end

@implementation SWGestureViewDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(self.gestureRecognizerShouldReceiveTouch) return self.gestureRecognizerShouldReceiveTouch(gestureRecognizer,touch);
    return YES;
}

//- (void)dealloc
//{
//    NSLog(@"%@ __dealloc__",[self class]);
//}

@end

@interface UIView ()

@property (nonatomic,strong) SWGestureActionBlock sw_gestureActionBlock;
@property (nonatomic,strong) SWGestureViewDelegate *sw_gestureViewDelegate;
@property (nonatomic,strong) UITapGestureRecognizer *sw_tapGestureRecognizerAdd;

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

- (void)setSw_gestureViewDelegate:(SWGestureViewDelegate *)sw_gestureViewDelegate {
    objc_setAssociatedObject(self, @selector(sw_gestureViewDelegate), sw_gestureViewDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SWGestureViewDelegate *)sw_gestureViewDelegate {
    
    return objc_getAssociatedObject(self, @selector(sw_gestureViewDelegate));
}

- (void)setSw_tapGestureRecognizerAdd:(UITapGestureRecognizer *)sw_tapGestureRecognizerAdd {
    objc_setAssociatedObject(self, @selector(sw_tapGestureRecognizerAdd), sw_tapGestureRecognizerAdd, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)sw_tapGestureRecognizerAdd {
    return objc_getAssociatedObject(self, @selector(sw_tapGestureRecognizerAdd));
}

- (void)sw_addGestureRecognizerWithClass:(Class)gestureRecognizerClass delegate:(id<UIGestureRecognizerDelegate> _Nullable)delegate actionBlock:(SWGestureActionBlock)gestureActionBlock {
    NSAssert([gestureRecognizerClass instancesRespondToSelector:@selector(initWithTarget:action:)], @"必须是UIGestureRecognizer类");
    UIGestureRecognizer *gesture = [[gestureRecognizerClass alloc] initWithTarget:self action:@selector(sw_handleGesture:)];
    gesture.delegate = delegate;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gesture];
    self.sw_gestureActionBlock = gestureActionBlock;
}

- (void)sw_addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withDelegate:(id<UIGestureRecognizerDelegate> _Nullable)delegate actionBlock:(SWGestureActionBlock)gestureActionBlock {
    NSAssert([gestureRecognizer isKindOfClass:[UIGestureRecognizer class]], @"必须是UIGestureRecognizer类");
    [gestureRecognizer addTarget:self action:@selector(sw_handleGesture:)];
    gestureRecognizer.delegate = delegate;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gestureRecognizer];
    self.sw_gestureActionBlock = gestureActionBlock;
}


- (void)sw_addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer withActionBlock:(SWGestureActionBlock)gestureActionBlock {
    NSAssert([gestureRecognizer isKindOfClass:[UIGestureRecognizer class]], @"必须是UIGestureRecognizer类");
    [gestureRecognizer addTarget:self action:@selector(sw_handleGesture:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:gestureRecognizer];
    self.sw_gestureActionBlock = gestureActionBlock;
}

- (void)sw_addTapGestureRecognizerWithActionBlock:(SWGestureActionBlock)gestureActionBlock {
    [self sw_addGestureRecognizer:[UITapGestureRecognizer new] withActionBlock:gestureActionBlock];
}

- (void)sw_addTapGestureRecognizerWithActionBlock:(SWGestureActionBlock)gestureActionBlock gestureRecognizerShouldReceiveTouch:(BOOL(^)(UIGestureRecognizer *ges,UITouch *touch))gestureRecognizerShouldReceiveTouch {
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    if(self.sw_gestureViewDelegate == nil){
        self.sw_gestureViewDelegate = [SWGestureViewDelegate new];
    }
    self.sw_gestureViewDelegate.gestureRecognizerShouldReceiveTouch = gestureRecognizerShouldReceiveTouch;
    tap.delegate = self.sw_gestureViewDelegate;
    [self sw_addGestureRecognizer:tap withActionBlock:gestureActionBlock];
}

- (void)sw_tapGestureRecognizerWithActionBlock:(SWGestureActionBlock)gestureActionBlock gestureRecognizerShouldReceiveTouch:(BOOL(^)(UIGestureRecognizer *ges,UITouch *touch))gestureRecognizerShouldReceiveTouch {
    if(self.sw_tapGestureRecognizerAdd){
        [self removeGestureRecognizer:self.sw_tapGestureRecognizerAdd];
        self.sw_tapGestureRecognizerAdd = nil;
    }
    self.sw_tapGestureRecognizerAdd = [UITapGestureRecognizer new];
    if(self.sw_gestureViewDelegate == nil){
        self.sw_gestureViewDelegate = [SWGestureViewDelegate new];
    }
    self.sw_gestureViewDelegate.gestureRecognizerShouldReceiveTouch = gestureRecognizerShouldReceiveTouch;
    self.sw_tapGestureRecognizerAdd.delegate = self.sw_gestureViewDelegate;
    [self sw_addGestureRecognizer:self.sw_tapGestureRecognizerAdd withActionBlock:gestureActionBlock];
}

- (void)sw_tapGestureRecognizerWithActionBlock:(SWGestureActionBlock)gestureActionBlock {
    [self sw_tapGestureRecognizerWithActionBlock:gestureActionBlock gestureRecognizerShouldReceiveTouch:nil];
}


- (void)sw_handleGesture:(UITapGestureRecognizer *)gesture {
    if(self.sw_gestureActionBlock){
        self.sw_gestureActionBlock(gesture);
    }
}



@end
