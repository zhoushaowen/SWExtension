//
//  UIViewController+SWImagePicker.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIViewController+SWImagePicker.h"
#import "UIViewController+Authorization.h"
#import <objc/runtime.h>

static void *SWImagePickerDelegate_Key = &SWImagePickerDelegate_Key;

@interface UIViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) id<SWImagePickerControllerDelegate> swImagePickerDelegate;

@end

@implementation UIViewController (SWImagePicker)

#pragma mark - Public
- (UIImagePickerController *)sw_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate {
    self.swImagePickerDelegate = delegate;
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        [self showAlertWithSourceType:sourceType];
        return nil;
    }
    if(sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        if(![self sw_isHaveCameraAuthorization])
            return nil;
    }else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary || sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum)
    {
        if(![self sw_isHavePhotoLibarayAuthorization])
            return nil;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    return imagePickerController;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //在选择图片的时候如果什么不做处理会导致内存暴增
    //然而,通过压缩图片的方式并不能解决内存暴增的弊端(UIImageJPEGRepresentation)
    UIImage *image = nil;
    if(picker.allowsEditing){
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    //正确的做法是:通过上下文绘制一个新的图片可以解决进行图片选择的时候内存暴增的问题
    UIImage *resultImage = [self drawImageWithOriginalImage:image width:[UIScreen mainScreen].bounds.size.width];
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_imagePickerController:didFinishPickingImage:)]){
        [self.swImagePickerDelegate sw_imagePickerController:picker didFinishPickingImage:resultImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_imagePickerControllerDidCancel:)]){
        [self.swImagePickerDelegate sw_imagePickerControllerDidCancel:picker];
    }
}


#pragma mark - Private
- (UIImage *)drawImageWithOriginalImage:(UIImage *)originalImage width:(CGFloat)width {
    CGFloat scale = originalImage.size.height/originalImage.size.width;
    CGFloat height = scale*width;
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    [originalImage drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (void)showAlertWithSourceType:(UIImagePickerControllerSourceType)type
{
    NSString *message = nil;
    if(type ==UIImagePickerControllerSourceTypeCamera)
    {
        message = @"相机不可用";
    }else if(type ==UIImagePickerControllerSourceTypePhotoLibrary)
    {
        message = @"相册不可用";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setSwImagePickerDelegate:(id<SWImagePickerControllerDelegate>)swImagePickerDelegate {
    objc_setAssociatedObject(self, SWImagePickerDelegate_Key, swImagePickerDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<SWImagePickerControllerDelegate>)swImagePickerDelegate {
    return objc_getAssociatedObject(self, SWImagePickerDelegate_Key);
}


@end