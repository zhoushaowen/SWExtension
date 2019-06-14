//
//  UIImage+SWQRCode.h
//  生成二维码和条形码
//
//  Created by 周少文 on 16/1/20.
//  Copyright © 2016年 ZheJiangWanHang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SWQRCode)

//生成二维码
+ (UIImage *)sw_createQRCodeWithString:(NSString *)string width:(CGFloat)width height:(CGFloat)height;
//创建一个带颜色的二维码
+ (UIImage *)sw_createQRCodeWithString:(NSString *)string color:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;
//生成条形码
+ (UIImage *)sw_createBarCodeWithString:(NSString *)string width:(CGFloat)width height:(CGFloat)height;

@end
