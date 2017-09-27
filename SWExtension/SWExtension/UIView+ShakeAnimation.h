//
//  UIView+ShakeAnimation.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const SWShakeOnceAnimation;
extern NSString *const SWShakeRepeatAnimation;

@interface UIView (ShakeAnimation)

- (void)shakeOnceAnimation;
- (void)shakeRepeatAnimation;

@end
