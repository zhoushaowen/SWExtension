//
//  UITextView+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "UITextView+SWExtension.h"
#import <objc/runtime.h>
#import <ReactiveObjC.h>
#import "NSObject+SWMethodChange.h"

@implementation UITextView (SWExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self sw_exchangeMethodWithSystemSelector:@selector(initWithFrame:textContainer:) customSelector:@selector(swExtension_initWithFrame:textContainer:)];
        [self sw_exchangeMethodWithSystemSelector:@selector(initWithCoder:) customSelector:@selector(swExtension_initWithCoder:)];
    });
}

- (instancetype)swExtension_initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    UITextView *tv = [self swExtension_initWithFrame:frame textContainer:textContainer];
    if(tv){
        [self swExtension_addNotifiObserver];
    }
    return tv;
}

- (instancetype)swExtension_initWithCoder:(NSCoder *)coder
{
    UITextView *tv = [self swExtension_initWithCoder:coder];
    if (tv) {
        [self swExtension_addNotifiObserver];
    }
    return tv;
}

- (void)setSw_textDidChangeBlock:(void (^)(UITextView * _Nonnull))sw_textDidChangeBlock {
    objc_setAssociatedObject(self, @selector(sw_textDidChangeBlock), sw_textDidChangeBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UITextView * _Nonnull))sw_textDidChangeBlock {
    return objc_getAssociatedObject(self, @selector(sw_textDidChangeBlock));
}

- (void)setSw_textDidBeginEditingBlock:(void (^)(UITextView * _Nonnull))sw_textDidBeginEditingBlock {
    objc_setAssociatedObject(self, @selector(sw_textDidBeginEditingBlock), sw_textDidBeginEditingBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UITextView * _Nonnull))sw_textDidBeginEditingBlock {
    return objc_getAssociatedObject(self, @selector(sw_textDidBeginEditingBlock));
}

- (void)setSw_textDidEndEditingBlock:(void (^)(UITextView * _Nonnull))sw_textDidEndEditingBlock {
    objc_setAssociatedObject(self, @selector(sw_textDidEndEditingBlock), sw_textDidEndEditingBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UITextView * _Nonnull))sw_textDidEndEditingBlock {
    return objc_getAssociatedObject(self, @selector(sw_textDidEndEditingBlock));
}

- (void)swExtension_addNotifiObserver {
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidEndEditingNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.sw_textDidEndEditingBlock) self.sw_textDidEndEditingBlock(self);
    }];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidChangeNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.sw_textDidChangeBlock) self.sw_textDidChangeBlock(self);
    }];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextViewTextDidBeginEditingNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.sw_textDidBeginEditingBlock) self.sw_textDidBeginEditingBlock(self);
    }];
    
}

@end
