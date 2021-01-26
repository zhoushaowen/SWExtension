//
//  UIView+SWHitTestExtension.m
//  hitTest练习
//
//  Created by zhoushaowen on 2021/1/25.
//  Copyright © 2021 WanHang. All rights reserved.
//

#import "UIView+SWHitTestExtension.h"
#import "NSObject+SWMethodChange.h"
#import <objc/runtime.h>

@implementation UIView (SWHitTestExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self sw_exchangeMethodWithSystemSelector:@selector(hitTest:withEvent:) customSelector:@selector(sw_hitTest:withEvent:)];
    });
}

- (void)setSw_hitTestTargetView:(UIView * _Nonnull (^)(CGPoint, UIEvent * _Nonnull, UIView * _Nonnull))sw_hitTestTargetView {
    objc_setAssociatedObject(self, @selector(sw_hitTestTargetView), sw_hitTestTargetView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView * _Nonnull (^)(CGPoint, UIEvent * _Nonnull, UIView * _Nonnull))sw_hitTestTargetView {
    return objc_getAssociatedObject(self, @selector(sw_hitTestTargetView));
}

- (void)setSw_eventThroughView:(UIView * _Nonnull (^)(CGPoint, UIEvent * _Nonnull, UIView * _Nonnull))sw_eventThroughView {
    objc_setAssociatedObject(self, @selector(sw_eventThroughView), sw_eventThroughView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView * _Nonnull (^)(CGPoint, UIEvent * _Nonnull, UIView * _Nonnull))sw_eventThroughView {
    return objc_getAssociatedObject(self, @selector(sw_eventThroughView));
}

- (UIView *)sw_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *originalTargetView = [self sw_hitTest:point withEvent:event];
    UIView *eventThroughView = self.sw_eventThroughView? self.sw_eventThroughView(point,event,originalTargetView):nil;
    if(eventThroughView){
        
        CGPoint eventThroughViewPoint = [self convertPoint:point toView:eventThroughView];
//        if([canReceiveEventBehindView pointInside:behindViewPoint withEvent:event] && !canReceiveEventBehindView.isHidden &&
//           canReceiveEventBehindView.isUserInteractionEnabled &&
//           canReceiveEventBehindView.alpha > 0.01
//           ){
//            return canReceiveEventBehindView;
//        }
        UIView *eventThroughTargetView = [eventThroughView hitTest:eventThroughViewPoint withEvent:event];
        if(eventThroughTargetView) return eventThroughTargetView;
    }
    else if(self.sw_hitTestTargetView){
        UIView *hitTestTargetView = self.sw_hitTestTargetView(point,event,originalTargetView);
        if(hitTestTargetView) return hitTestTargetView;
    }
    return originalTargetView;
}


@end
