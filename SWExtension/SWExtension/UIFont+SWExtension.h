//
//  UIFont+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/22.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (SWExtension)

/**
 设置大小生成一个细体字,支持ios9以下的系统

 @param size 字体大小
 @return 字体
 */
+ (UIFont *)sw_lightFontWithSize:(UIFont *)size;

@end
