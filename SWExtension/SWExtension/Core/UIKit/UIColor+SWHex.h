//
//  UIColor+SWHex.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SWHex)

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHexString:(NSString *)hex withAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hex withAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hex;

@end
