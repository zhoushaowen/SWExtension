//
//  UIFont+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/22.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIFont+SWExtension.h"

@implementation UIFont (SWExtension)

+ (UIFont *)sw_lightFontWithSize:(CGFloat)size {
    if([[[UIDevice currentDevice] systemVersion] compare:@"8.2" options:NSNumericSearch] != NSOrderedAscending){
        return [UIFont systemFontOfSize:size weight:UIFontWeightLight];
    }else{
        return [UIFont systemFontOfSize:size weight:-0.4];
    }
}

@end
