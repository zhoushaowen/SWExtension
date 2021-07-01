//
//  UIView+SWBorderStyle.m
//  Pharmacist-role
//
//  Created by zhoushaowen on 2019/6/4.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "UIView+SWBorderStyle.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, SWExtensionBorderStyleViewType) {
    SWExtensionBorderStyleViewTypeTop,
    SWExtensionBorderStyleViewTypeLeft,
    SWExtensionBorderStyleViewTypeBottom,
    SWExtensionBorderStyleViewTypeRight,
};

@interface SWExtensionBorderStyleView : UIView

@property (nonatomic) SWExtensionBorderStyleViewType borderType;
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat borderWidth;

@end

@implementation SWExtensionBorderStyleView

- (void)layoutSubviews {
    [super layoutSubviews];
    UIEdgeInsets insets = self.insets;
    switch (self.borderType) {
        case SWExtensionBorderStyleViewTypeTop:
            {
                self.frame = CGRectMake(insets.left, insets.top, self.superview.bounds.size.width - insets.left - insets.right, self.borderWidth);
            }
            break;
        case SWExtensionBorderStyleViewTypeLeft:
            {
                self.frame = CGRectMake(insets.left, insets.top, self.borderWidth, self.superview.bounds.size.height - insets.top - insets.bottom);
            }
            break;
        case SWExtensionBorderStyleViewTypeBottom:
            {
                self.frame = CGRectMake(insets.left, self.superview.bounds.size.height - self.borderWidth - insets.bottom, self.superview.bounds.size.width - insets.left - insets.right, self.borderWidth);
            }
            break;
        case SWExtensionBorderStyleViewTypeRight:
            {
                self.frame = CGRectMake(self.superview.bounds.size.width - self.borderWidth - insets.right, insets.top, self.borderWidth, self.superview.bounds.size.height - insets.top - insets.bottom);
            }
            break;
            
        default:
            break;
    }
}

@end

@interface UIView ()

@property (nonatomic,strong) SWExtensionBorderStyleView *sw_topBorderLine;
@property (nonatomic,strong) SWExtensionBorderStyleView *sw_leftBorderLine;
@property (nonatomic,strong) SWExtensionBorderStyleView *sw_bottomBorderLine;
@property (nonatomic,strong) SWExtensionBorderStyleView *sw_rightBorderLine;

@end

@implementation UIView (SWBorderStyle)

- (void)sw_updateBorderStyle:(BOOL)isNeedsLayout {
    if(self.sw_borderTopWidth > 0){
        if(self.sw_topBorderLine == nil){
            self.sw_topBorderLine = [[SWExtensionBorderStyleView alloc] init];
            self.sw_topBorderLine.borderType = SWExtensionBorderStyleViewTypeTop;
        }
        self.sw_topBorderLine.backgroundColor = self.sw_borderTopColor;
        self.sw_topBorderLine.insets = self.sw_insetsForBorderTop;
        self.sw_topBorderLine.borderWidth = self.sw_borderTopWidth;
        if(self.sw_topBorderLine.superview != self){
            [self addSubview:self.sw_topBorderLine];
            [self.sw_topBorderLine setNeedsLayout];
        }
        if(isNeedsLayout){
            [self.sw_topBorderLine setNeedsLayout];
        }
    }else{
        [self.sw_topBorderLine removeFromSuperview];
    }
    
    if(self.sw_borderLeftWidth > 0){
        if(self.sw_leftBorderLine == nil){
            self.sw_leftBorderLine = [[SWExtensionBorderStyleView alloc] init];
            self.sw_leftBorderLine.borderType = SWExtensionBorderStyleViewTypeLeft;
        }
        self.sw_leftBorderLine.backgroundColor = self.sw_borderLeftColor;
        self.sw_leftBorderLine.insets = self.sw_insetsForBorderLeft;
        self.sw_leftBorderLine.borderWidth = self.sw_borderLeftWidth;
        if(self.sw_leftBorderLine.superview != self){
            [self addSubview:self.sw_leftBorderLine];
            [self.sw_leftBorderLine setNeedsLayout];
        }
        if(isNeedsLayout){
            [self.sw_leftBorderLine setNeedsLayout];
        }
    }else{
        [self.sw_leftBorderLine removeFromSuperview];
    }
    
    if(self.sw_borderBottomWidth > 0){
        if(self.sw_bottomBorderLine == nil){
            self.sw_bottomBorderLine = [[SWExtensionBorderStyleView alloc] init];
            self.sw_bottomBorderLine.borderType = SWExtensionBorderStyleViewTypeBottom;
        }
        self.sw_bottomBorderLine.backgroundColor = self.sw_borderBottomColor;
        self.sw_bottomBorderLine.insets = self.sw_insetsForBorderBottom;
        self.sw_bottomBorderLine.borderWidth = self.sw_borderBottomWidth;
        if(self.sw_bottomBorderLine.superview != self){
            [self addSubview:self.sw_bottomBorderLine];
            [self.sw_bottomBorderLine setNeedsLayout];
        }
        if(isNeedsLayout){
            [self.sw_bottomBorderLine setNeedsLayout];
        }
    }else{
        [self.sw_bottomBorderLine removeFromSuperview];
    }
    
    if(self.sw_borderRightWidth > 0){
        if(self.sw_rightBorderLine == nil){
            self.sw_rightBorderLine = [[SWExtensionBorderStyleView alloc] init];
            self.sw_rightBorderLine.borderType = SWExtensionBorderStyleViewTypeRight;
        }
        self.sw_rightBorderLine.backgroundColor = self.sw_borderRightColor;
        self.sw_bottomBorderLine.insets = self.sw_insetsForBorderRight;
        self.sw_bottomBorderLine.borderWidth = self.sw_borderBottomWidth;
        if(self.sw_rightBorderLine.superview != self){
            [self addSubview:self.sw_rightBorderLine];
            [self.sw_rightBorderLine setNeedsLayout];
        }
        if(isNeedsLayout){
            [self.sw_rightBorderLine setNeedsLayout];
        }
    }else{
        [self.sw_rightBorderLine removeFromSuperview];
    }
}

#pragma mark - width
- (void)setSw_borderTopWidth:(CGFloat)sw_borderTopWidth {
    BOOL isNeedsLayout = sw_borderTopWidth != self.sw_borderTopWidth;
    objc_setAssociatedObject(self, @selector(sw_borderTopWidth), @(sw_borderTopWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
}

- (CGFloat)sw_borderTopWidth {
    return [objc_getAssociatedObject(self, @selector(sw_borderTopWidth)) doubleValue];
}

- (void)setSw_borderLeftWidth:(CGFloat)sw_borderLeftWidth {
    BOOL isNeedsLayout = sw_borderLeftWidth != self.sw_borderLeftWidth;
    objc_setAssociatedObject(self, @selector(sw_borderLeftWidth), @(sw_borderLeftWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
}

- (CGFloat)sw_borderLeftWidth {
    return [objc_getAssociatedObject(self, @selector(sw_borderLeftWidth)) doubleValue];
}

- (void)setSw_borderBottomWidth:(CGFloat)sw_borderBottomWidth {
    BOOL isNeedsLayout = sw_borderBottomWidth != self.sw_borderBottomWidth;
    objc_setAssociatedObject(self, @selector(sw_borderBottomWidth), @(sw_borderBottomWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
}

- (CGFloat)sw_borderBottomWidth {
    return [objc_getAssociatedObject(self, @selector(sw_borderBottomWidth)) doubleValue];
}

- (void)setSw_borderRightWidth:(CGFloat)sw_borderRightWidth {
    BOOL isNeedsLayout = sw_borderRightWidth != self.sw_borderRightWidth;
    objc_setAssociatedObject(self, @selector(sw_borderRightWidth), @(sw_borderRightWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
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
    self.sw_topBorderLine.backgroundColor = sw_borderTopColor;
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
    self.sw_leftBorderLine.backgroundColor = sw_borderLeftColor;
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
    self.sw_bottomBorderLine.backgroundColor = sw_borderBottomColor;
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
    self.sw_rightBorderLine.backgroundColor = sw_borderRightColor;
}

- (UIColor *)sw_borderRightColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(sw_borderRightColor));
    if(color == nil){
        color = [UIColor blackColor];
    }
    return color;
}

#pragma mark - insets
- (void)setSw_insetsForBorderTop:(UIEdgeInsets)sw_insetsForBorderTop {
    BOOL isNeedsLayout = !UIEdgeInsetsEqualToEdgeInsets(sw_insetsForBorderTop, self.sw_insetsForBorderTop);
    objc_setAssociatedObject(self, @selector(sw_insetsForBorderTop), [NSValue valueWithUIEdgeInsets:sw_insetsForBorderTop], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
}

- (UIEdgeInsets)sw_insetsForBorderTop {
    return [objc_getAssociatedObject(self, @selector(sw_insetsForBorderTop)) UIEdgeInsetsValue];
}

- (void)setSw_insetsForBorderLeft:(UIEdgeInsets)sw_insetsForBorderLeft {
    BOOL isNeedsLayout = !UIEdgeInsetsEqualToEdgeInsets(sw_insetsForBorderLeft, self.sw_insetsForBorderLeft);
    objc_setAssociatedObject(self, @selector(sw_insetsForBorderLeft), [NSValue valueWithUIEdgeInsets:sw_insetsForBorderLeft], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
}

- (UIEdgeInsets)sw_insetsForBorderLeft {
    return [objc_getAssociatedObject(self, @selector(sw_insetsForBorderLeft)) UIEdgeInsetsValue];
}

- (void)setSw_insetsForBorderBottom:(UIEdgeInsets)sw_insetsForBorderBottom {
    BOOL isNeedsLayout = !UIEdgeInsetsEqualToEdgeInsets(sw_insetsForBorderBottom, self.sw_insetsForBorderBottom);
    objc_setAssociatedObject(self, @selector(sw_insetsForBorderBottom), [NSValue valueWithUIEdgeInsets:sw_insetsForBorderBottom], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
}

- (UIEdgeInsets)sw_insetsForBorderBottom {
    return [objc_getAssociatedObject(self, @selector(sw_insetsForBorderBottom)) UIEdgeInsetsValue];
}

- (void)setSw_insetsForBorderRight:(UIEdgeInsets)sw_insetsForBorderRight {
    BOOL isNeedsLayout = !UIEdgeInsetsEqualToEdgeInsets(sw_insetsForBorderRight, self.sw_insetsForBorderRight);
    objc_setAssociatedObject(self, @selector(sw_insetsForBorderRight), [NSValue valueWithUIEdgeInsets:sw_insetsForBorderRight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sw_updateBorderStyle:isNeedsLayout];
}

- (UIEdgeInsets)sw_insetsForBorderRight {
    return [objc_getAssociatedObject(self, @selector(sw_insetsForBorderRight)) UIEdgeInsetsValue];
}



@end
