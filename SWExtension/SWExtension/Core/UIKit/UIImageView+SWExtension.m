//
//  UIImageView+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIImageView+SWExtension.h"

@implementation UIImageView (SWExtension)

+ (instancetype)sw_imageViewWithContentMode:(UIViewContentMode)contentMode
{
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.contentMode = contentMode;
    if(contentMode == UIViewContentModeScaleAspectFill){
        imgV.clipsToBounds = YES;
    }
    return imgV;
}

@end
