//
//  UIImage+SWQRCode.m
//  生成二维码和条形码
//
//  Created by 周少文 on 16/1/20.
//  Copyright © 2016年 ZheJiangWanHang. All rights reserved.
//

#import "UIImage+SWQRCode.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (SWQRCode)

// 参考文档
// https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html

//生成二维码
+ (UIImage *)sw_createQRCodeWithString:(NSString *)string width:(CGFloat)width height:(CGFloat)height {
//    NSData *data = [self dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
    //实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    //将NSString转成NSData
    NSData *data = [string?:@"" dataUsingEncoding:NSUTF8StringEncoding];
    //设置内容
    [filter setValue:data forKey:@"inputMessage"];
    /*二维码容错等级
     L级,7％的码字可以被恢复。
     M级,15％可以被恢复。
     Q级,25％可以被恢复。
     H级,30％可以被恢复。
     */
    //设置纠错级别
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    //生成二维码
    CIImage *qrcodeImage = [filter outputImage];
    // 消除模糊
//    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
//    CGFloat scaleY = height / qrcodeImage.extent.size.height;
//    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
//    return [UIImage imageWithCIImage:transformedImage];
    return [self sw_createNonInterpolatedUIImageFormCIImage:qrcodeImage withWidth:width height:height];
}

//创建一个带颜色的二维码
+ (UIImage *)sw_createQRCodeWithString:(NSString *)string color:(UIColor *)color width:(CGFloat)width height:(CGFloat)height {
   UIImage *image = [self sw_createQRCodeWithString:string width:width height:height];
    NSArray *rgb = [self sw_changeUIColorToRGB:color];
    return [self sw_imageBlackToTransparent:image withRed:[rgb[0] floatValue] andGreen:[rgb[1] floatValue] andBlue:[rgb[2] floatValue]];
}

//生成条形码
+ (UIImage *)sw_createBarCodeWithString:(NSString *)string width:(CGFloat)width height:(CGFloat)height {
//    NSData *data = [self dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setDefaults];
    NSData *data = [string?:@"" dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *barcodeImage = [filter outputImage];
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

//放大二维码
+ (UIImage *)sw_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withWidth:(CGFloat)aWidth height:(CGFloat)aHeight {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(aWidth/CGRectGetWidth(extent), aHeight/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//给二维码上色
void SWProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
+ (UIImage*)sw_imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, SWProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

//将UIColor转换为RGB值
+ (NSMutableArray *)sw_changeUIColorToRGB:(UIColor *)color
{
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    //获取红色值
    int r = [[RGBArr objectAtIndex:1] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",r];
    [RGBStrValueArr addObject:RGBStr];
    //获取绿色值
    int g = [[RGBArr objectAtIndex:2] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",g];
    [RGBStrValueArr addObject:RGBStr];
    //获取蓝色值
    int b = [[RGBArr objectAtIndex:3] intValue] * 255;
    RGBStr = [NSString stringWithFormat:@"%d",b];
    [RGBStrValueArr addObject:RGBStr];
    //返回保存RGB值的数组
    return RGBStrValueArr;
}


@end
