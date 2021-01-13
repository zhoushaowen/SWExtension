//
//  UITextField+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "UITextField+SWExtension.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "NSObject+SWMethodChange.h"
#import <objc/runtime.h>

@implementation UITextField (SWExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self sw_exchangeMethodWithSystemSelector:@selector(initWithFrame:) customSelector:@selector(swExtension_initWithFrame:)];
        [self sw_exchangeMethodWithSystemSelector:@selector(initWithCoder:) customSelector:@selector(swExtension_initWithCoder:)];
    });
}

- (instancetype)swExtension_initWithFrame:(CGRect)frame
{
    UITextField *tf = [self swExtension_initWithFrame:frame];
    if(tf){
        [self swExtension_addNotifiObserver];
    }
    return tf;
}

- (instancetype)swExtension_initWithCoder:(NSCoder *)coder
{
    UITextField *tf = [self swExtension_initWithCoder:coder];
    if (tf) {
        [self swExtension_addNotifiObserver];
    }
    return tf;
}

- (void)setSw_textDidChangeBlock:(void (^)(UITextField * _Nonnull))sw_textDidChangeBlock {
    objc_setAssociatedObject(self, @selector(sw_textDidChangeBlock), sw_textDidChangeBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UITextField * _Nonnull))sw_textDidChangeBlock {
    return objc_getAssociatedObject(self, @selector(sw_textDidChangeBlock));
}

- (void)setSw_textDidBeginEditingBlock:(void (^)(UITextField * _Nonnull))sw_textDidBeginEditingBlock {
    objc_setAssociatedObject(self, @selector(sw_textDidBeginEditingBlock), sw_textDidBeginEditingBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UITextField * _Nonnull))sw_textDidBeginEditingBlock {
    return objc_getAssociatedObject(self, @selector(sw_textDidBeginEditingBlock));
}

- (void)setSw_textDidEndEditingBlock:(void (^)(UITextField * _Nonnull))sw_textDidEndEditingBlock {
    objc_setAssociatedObject(self, @selector(sw_textDidEndEditingBlock), sw_textDidEndEditingBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UITextField * _Nonnull))sw_textDidEndEditingBlock {
    return objc_getAssociatedObject(self, @selector(sw_textDidEndEditingBlock));
}

- (void)swExtension_addNotifiObserver {
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidEndEditingNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.sw_textDidEndEditingBlock) self.sw_textDidEndEditingBlock(self);
    }];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidChangeNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.sw_textDidChangeBlock) self.sw_textDidChangeBlock(self);
    }];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidBeginEditingNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.sw_textDidBeginEditingBlock) self.sw_textDidBeginEditingBlock(self);
    }];

}

@end
