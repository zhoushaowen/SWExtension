//
//  UIScrollView+FitIOS11.m
//  Loko_iOS
//
//  Created by zhoushaowen on 2017/9/19.
//  Copyright © 2017年 loko. All rights reserved.
//

#import "UIScrollView+FitIOS11.h"

@implementation UIScrollView (FitIOS11)

- (void)sw_disableContentInsetAdjustmentBehavior {
    //适配ios11
#ifdef __IPHONE_11_0
    if([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]){
        [self setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
#endif
}

@end
