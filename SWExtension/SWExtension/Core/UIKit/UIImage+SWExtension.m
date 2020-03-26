//
//  UIImage+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIImage+SWExtension.h"

@implementation UIImage (SWExtension)

+ (UIImage *)sw_createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)sw_createImageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)sw_createOvalImageWithColor:(UIColor *)color inSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)sw_clipImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *beizer = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [beizer addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)sw_clipImageWithCornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:cornerRadius];
    [bezier addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)sw_imageWithClipImage:(UIImage *)image __deprecated
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *beizer = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [beizer addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)sw_imageWithClipImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius __deprecated
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:cornerRadius];
    [bezier addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark - 拉伸图片
- (UIImage *)sw_stretchableImage {
    UIImage *resultImage = [self stretchableImageWithLeftCapWidth:self.size.width/2.0 topCapHeight:self.size.height/2.0];
    return resultImage;
}

- (UIImage *)sw_resizableImageWithCapInsets:(UIEdgeInsets)insets {
    return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)sw_stretchableImageWithOriginalImage:(UIImage *)image __deprecated
{
    UIImage *resultImage = [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
    return resultImage;
}

+ (UIImage *)sw_resizableImageWithCapInsets:(UIEdgeInsets)insets imageNamed:(NSString *)imageName __deprecated
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

#pragma mark - 压缩图片
- (UIImage *)sw_compressImageWithMaxWidth:(CGFloat)maxWidth maxLength:(NSUInteger)maxLength {
    UIImage *image = [self sw_drawImageWithMaxWidth:maxWidth];
    return [image sw_compressImageWithMaxLength:maxLength];
}

- (UIImage *)sw_drawImageWithMaxWidth:(CGFloat)maxWidth {
    if(self.size.width <= maxWidth) return self;
    CGFloat scale = self.size.height/self.size.width;
    CGFloat height = scale*maxWidth;
    CGRect rect = CGRectMake(0, 0, maxWidth, height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    [self drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)sw_compressImageWithMaxLength:(NSUInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return self;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return [[UIImage alloc] initWithData:data];
}

#pragma mark - 截图
- (UIImage *)sw_captureImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
