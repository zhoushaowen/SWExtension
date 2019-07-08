//
//  UIImage+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SWExtension)


/**
 通过颜色创建一个图片

 @param color 颜色
 @return 生成的图片
 */
+ (UIImage *)sw_createImageWithColor:(UIColor *)color;

/**
 通过颜色创建一个指定大小图片

 @param color 颜色
 @param size 图片大小
 @return 生成的图片
 */
+ (UIImage *)sw_createImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 通过颜色创建一个圆角图片

 @param color 颜色
 @param size 图片的大小
 @return 生成的图片
 */
+ (UIImage *)sw_createOvalImageWithColor:(UIColor *)color inSize:(CGSize)size;
///图片切圆角
- (UIImage *)sw_clipImage;
/// 图片切圆角,圆角度数自定义
- (UIImage *)sw_clipImageWithCornerRadius:(CGFloat)cornerRadius;
///压缩图片
- (UIImage *)sw_compressImageWithMaxWidth:(CGFloat)maxWidth maxLength:(NSUInteger)maxLength;
///拉伸图片
- (UIImage *)sw_stretchableImage;
- (UIImage *)sw_resizableImageWithCapInsets:(UIEdgeInsets)insets;
#pragma mark - deprecated
/**拉伸图片 已废弃*/
+ (UIImage *)sw_stretchableImageWithOriginalImage:(UIImage *)image __deprecated_msg("Use 'sw_stretchableImage'");
+ (UIImage *)sw_resizableImageWithCapInsets:(UIEdgeInsets)insets imageNamed:(NSString *)imageName __deprecated_msg("Use 'sw_resizableImageWithCapInsets'");
/**
 图片切圆角
 
 @param image 原始图片
 @return 生成的圆角图片
 */
+ (UIImage *)sw_imageWithClipImage:(UIImage *)image __deprecated_msg("Use 'sw_clipImage'");

/**
 图片切圆角,圆角度数自定义
 
 @param image image 原始图片
 @param cornerRadius 圆角度数
 @return 生成的圆角图片
 */
+ (UIImage *)sw_imageWithClipImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius __deprecated_msg("Use 'sw_resizableImageWithCapInsets:'");

@end
