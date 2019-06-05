//
//  UIView+SWBorderStyle.m
//  Pharmacist-role
//
//  Created by zhoushaowen on 2019/6/4.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "UIView+SWBorderStyle.h"
#import <objc/runtime.h>
#import <NSObject+RACKVOWrapper.h>
#import <RACEXTScope.h>

@interface UIView ()

@property (nonatomic,strong) CALayer *sw_topBorderLine;
@property (nonatomic,strong) CALayer *sw_leftBorderLine;
@property (nonatomic,strong) CALayer *sw_bottomBorderLine;
@property (nonatomic,strong) CALayer *sw_rightBorderLine;

@end

@implementation UIView (SWBorderStyle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeSystemSel:@selector(initWithFrame:) withCustomSel:@selector(swBorderStyle_initWithFrame:)];
        [self exchangeSystemSel:@selector(initWithCoder:) withCustomSel:@selector(swBorderStyle_initWithCoder:)];
    });
}

+ (void)exchangeSystemSel:(SEL)sysSel withCustomSel:(SEL)cusSel {
    Method sysM = class_getInstanceMethod([self class], sysSel);
    Method cusM = class_getInstanceMethod([self class], cusSel);
    if(class_addMethod([self class], sysSel, method_getImplementation(cusM), method_getTypeEncoding(cusM))){
        class_replaceMethod([self class], cusSel, method_getImplementation(sysM), method_getTypeEncoding(sysM));
    }else{
        method_exchangeImplementations(sysM, cusM);
    }
}

- (instancetype)swBorderStyle_initWithFrame:(CGRect)frame {
    @weakify(self)
    [self rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self)
        [self sw_updateBorderStyle];
    }];
    return [self swBorderStyle_initWithFrame:frame];
}

- (instancetype)swBorderStyle_initWithCoder:(NSCoder *)aDecoder {
    @weakify(self)
    [self rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self)
        [self sw_updateBorderStyle];
    }];
    return [self swBorderStyle_initWithCoder:aDecoder];
}

- (void)sw_updateBorderStyle {
    if(self.sw_borderTopWidth > 0){
        if(self.sw_topBorderLine == nil){
            self.sw_topBorderLine = [CALayer layer];
            self.sw_topBorderLine.backgroundColor = self.sw_borderTopColor.CGColor;
        }
        if(self.sw_topBorderLine.superlayer != self.layer){
            [self.layer addSublayer:self.sw_topBorderLine];
        }
        self.sw_topBorderLine.frame = CGRectMake(0, self.bounds.size.height - self.sw_borderTopWidth, self.bounds.size.width, self.sw_borderTopWidth);
    }else{
        [self.sw_topBorderLine removeFromSuperlayer];
    }
    
    if(self.sw_borderLeftWidth > 0){
        if(self.sw_leftBorderLine == nil){
            self.sw_leftBorderLine = [CALayer layer];
            self.sw_leftBorderLine.backgroundColor = self.sw_borderLeftColor.CGColor;
        }
        if(self.sw_leftBorderLine.superlayer != self.layer){
            [self.layer addSublayer:self.sw_leftBorderLine];
        }
        self.sw_leftBorderLine.frame = CGRectMake(0, self.bounds.size.height - self.sw_borderLeftWidth, self.bounds.size.width, self.sw_borderLeftWidth);
    }else{
        [self.sw_leftBorderLine removeFromSuperlayer];
    }

    if(self.sw_borderBottomWidth > 0){
        if(self.sw_bottomBorderLine == nil){
            self.sw_bottomBorderLine = [CALayer layer];
            self.sw_bottomBorderLine.backgroundColor = self.sw_borderBottomColor.CGColor;
        }
        if(self.sw_bottomBorderLine.superlayer != self.layer){
            [self.layer addSublayer:self.sw_bottomBorderLine];
        }
        self.sw_bottomBorderLine.frame = CGRectMake(0, self.bounds.size.height - self.sw_borderBottomWidth, self.bounds.size.width, self.sw_borderBottomWidth);
    }else{
        [self.sw_bottomBorderLine removeFromSuperlayer];
    }

    if(self.sw_borderRightWidth > 0){
        if(self.sw_rightBorderLine == nil){
            self.sw_rightBorderLine = [CALayer layer];
            self.sw_rightBorderLine.backgroundColor = self.sw_borderRightColor.CGColor;
        }
        if(self.sw_rightBorderLine.superlayer != self.layer){
            [self.layer addSublayer:self.sw_rightBorderLine];
        }
        self.sw_rightBorderLine.frame = CGRectMake(0, self.bounds.size.height - self.sw_borderRightWidth, self.bounds.size.width, self.sw_borderRightWidth);
    }else{
        [self.sw_rightBorderLine removeFromSuperlayer];
    }

}

#pragma mark - width
- (void)setSw_borderTopWidth:(CGFloat)sw_borderTopWidth {
    objc_setAssociatedObject(self, @selector(sw_borderTopWidth), @(sw_borderTopWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle];
}

- (CGFloat)sw_borderTopWidth {
    return [objc_getAssociatedObject(self, @selector(sw_borderTopWidth)) doubleValue];
}

- (void)setSw_borderLeftWidth:(CGFloat)sw_borderLeftWidth {
    objc_setAssociatedObject(self, @selector(sw_borderLeftWidth), @(sw_borderLeftWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle];
}

- (CGFloat)sw_borderLeftWidth {
    return [objc_getAssociatedObject(self, @selector(sw_borderLeftWidth)) doubleValue];
}

- (void)setSw_borderBottomWidth:(CGFloat)sw_borderBottomWidth {
    objc_setAssociatedObject(self, @selector(sw_borderBottomWidth), @(sw_borderBottomWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle];
}

- (CGFloat)sw_borderBottomWidth {
    return [objc_getAssociatedObject(self, @selector(sw_borderBottomWidth)) doubleValue];
}

- (void)setSw_borderRightWidth:(CGFloat)sw_borderRightWidth {
    objc_setAssociatedObject(self, @selector(sw_borderRightWidth), @(sw_borderRightWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle];
}

- (CGFloat)sw_borderRightWidth {
    return [objc_getAssociatedObject(self, @selector(sw_borderRightWidth)) doubleValue];
}

#pragma mark - layer
- (void)setSw_topBorderLine:(CALayer *)sw_topBorderLine {
    objc_setAssociatedObject(self, @selector(sw_topBorderLine), sw_topBorderLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)sw_topBorderLine {
    return objc_getAssociatedObject(self, @selector(sw_topBorderLine));
}

- (void)setSw_leftBorderLine:(CALayer *)sw_leftBorderLine {
    objc_setAssociatedObject(self, @selector(sw_leftBorderLine), sw_leftBorderLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)sw_leftBorderLine {
    return objc_getAssociatedObject(self, @selector(sw_leftBorderLine));
}

- (void)setSw_bottomBorderLine:(CALayer *)sw_bottomBorderLine {
    objc_setAssociatedObject(self, @selector(sw_bottomBorderLine), sw_bottomBorderLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)sw_bottomBorderLine {
    return objc_getAssociatedObject(self, @selector(sw_bottomBorderLine));
}

- (void)setSw_rightBorderLine:(CALayer *)sw_rightBorderLine {
    objc_setAssociatedObject(self, @selector(sw_rightBorderLine), sw_rightBorderLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)sw_rightBorderLine {
    return objc_getAssociatedObject(self, @selector(sw_rightBorderLine));
}

#pragma mark - color
- (void)setSw_borderTopColor:(UIColor *)sw_borderTopColor {
    objc_setAssociatedObject(self, @selector(sw_borderTopColor), sw_borderTopColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)sw_borderTopColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(sw_borderTopColor));
    if(color == nil){
        color = [UIColor blackColor];
    }
    return color;
}

- (void)setSw_borderLeftColor:(UIColor *)sw_borderLeftColor {
    objc_setAssociatedObject(self, @selector(sw_borderLeftColor), sw_borderLeftColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)sw_borderLeftColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(sw_borderLeftColor));
    if(color == nil){
        color = [UIColor blackColor];
    }
    return color;
}

- (void)setSw_borderBottomColor:(UIColor *)sw_borderBottomColor {
    objc_setAssociatedObject(self, @selector(sw_borderBottomColor), sw_borderBottomColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.sw_bottomBorderLine.backgroundColor = sw_borderBottomColor.CGColor;
}

- (UIColor *)sw_borderBottomColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(sw_borderBottomColor));
    if(color == nil){
        color = [UIColor blackColor];
    }
    return color;
}

- (void)setSw_borderRightColor:(UIColor *)sw_borderRightColor {
    objc_setAssociatedObject(self, @selector(sw_borderRightColor), sw_borderRightColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)sw_borderRightColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(sw_borderRightColor));
    if(color == nil){
        color = [UIColor blackColor];
    }
    return color;
}



@end
