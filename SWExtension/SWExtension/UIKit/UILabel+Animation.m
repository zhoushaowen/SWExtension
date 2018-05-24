//
//  UILabel+Animation.m
//  UILabelAnimation
//
//  Created by zhoushaowen on 2017/6/4.
//  Copyright © 2017年 loko. All rights reserved.
//

#import "UILabel+Animation.h"
#import <objc/runtime.h>

static NSString *const SWOmitAnimationPerformObjKey = @"SWOmitAnimationPerformObjKey";
static void *performCount_key = &performCount_key;
static void *isOmitAnimating_key = &isOmitAnimating_key;

@interface UILabel ()

@property (nonatomic) NSInteger performCount;
/**
 是否正在做省略动画
 */
@property (nonatomic) BOOL isOmitAnimating;

@end

@implementation UILabel (Animation)

#pragma mark - Public
- (void)beginOmitAnimation {
    NSAssert([NSThread currentThread].isMainThread, @"请在主线程执行UILabel动画");
    if(self.isOmitAnimating) return;
    self.isOmitAnimating = YES;
    [self performAnimation];
}

- (void)stopOmitAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(handlePerform) object:SWOmitAnimationPerformObjKey];
    self.text = [self.text substringToIndex:self.text.length - self.performCount];
    self.performCount = 0;
    self.isOmitAnimating = NO;
}

#pragma mark - Private
- (void)setPerformCount:(NSInteger)performCount {
    objc_setAssociatedObject(self, performCount_key, @(performCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)performCount {
    return [objc_getAssociatedObject(self, performCount_key) integerValue];
}

- (void)setIsOmitAnimating:(BOOL)isOmitAnimating {
    objc_setAssociatedObject(self, isOmitAnimating_key, @(isOmitAnimating), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isOmitAnimating {
    return [objc_getAssociatedObject(self, isOmitAnimating_key) boolValue];
}

- (void)performAnimation {
    [self performSelector:@selector(handlePerform) withObject:SWOmitAnimationPerformObjKey afterDelay:0.35f];
}

- (void)handlePerform {
    if(self.performCount == 3){
        self.text = [self.text substringToIndex:self.text.length - 3];
        self.performCount = 0;
        [self performAnimation];
        return;
    }
    self.text = [self.text?:@"" stringByAppendingString:@"."];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.performCount += 1;
    [self performAnimation];
}










@end
