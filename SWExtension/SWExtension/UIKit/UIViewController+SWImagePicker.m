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
#import <MobileCoreServices/UTCoreTypes.h>

typedef NS_ENUM(NSUInteger, SWImagePickerControllerMediaType) {
    SWImagePickerControllerMediaTypeImage = 1990,//图片
    SWImagePickerControllerMediaTypeMovie,//视频
};

@interface SWImagePickerController : UIImagePickerController

@property (nonatomic) SWImagePickerControllerMediaType sw_PickerControllerMediaType;
@property (nonatomic,strong) id sw_imagePickerUserInfo;

@end

@implementation SWImagePickerController

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end


static void *SWImagePickerDelegate_Key = &SWImagePickerDelegate_Key;

@interface UIViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) id<SWImagePickerControllerDelegate> swImagePickerDelegate;

@end

@implementation UIViewController (SWImagePicker)

#pragma mark - Public
- (UIImagePickerController *)sw_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate userInfo:(id)userInfo {
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
    SWImagePickerController *imagePickerController = [[SWImagePickerController alloc] init];
    imagePickerController.sw_PickerControllerMediaType = SWImagePickerControllerMediaTypeImage;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sw_imagePickerUserInfo = userInfo;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    return imagePickerController;
}

- (UIImagePickerController *)sw_presentVideoPickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate userInfo:(id)userInfo {
    SWImagePickerController *picker = (SWImagePickerController *)[self sw_presentImagePickerControllerWithSourceType:sourceType delegate:delegate userInfo:userInfo];
    picker.sw_PickerControllerMediaType = SWImagePickerControllerMediaTypeMovie;
    NSString *type = (__bridge_transfer NSString *)kUTTypeMovie;
    picker.mediaTypes = @[type];
    return picker;
}

- (UIImagePickerController *)sw_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate __deprecated_msg("Use 'sw_presentImagePickerControllerWithSourceType:delegate:userInfo:'") {
    return [self sw_presentImagePickerControllerWithSourceType:sourceType delegate:delegate userInfo:nil];
}

- (UIImagePickerController *)sw_presentVideoPickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate __deprecated_msg("Use 'sw_presentVideoPickerControllerWithSourceType:delegate:userInfo:'") {
    return [self sw_presentVideoPickerControllerWithSourceType:sourceType delegate:delegate userInfo:nil];
}

- (void)imagePickerController:(SWImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if(picker.sw_PickerControllerMediaType == SWImagePickerControllerMediaTypeImage){
        //在选择图片的时候如果什么不做处理会导致内存暴增
        //然而,通过压缩图片的方式并不能解决内存暴增的弊端(UIImageJPEGRepresentation)
        UIImage *image = nil;
        if(picker.allowsEditing){
            image = info[UIImagePickerControllerEditedImage];
        }else{
            image = info[UIImagePickerControllerOriginalImage];
        }
        //    NSData *imageData = UIImageJPEGRepresentation(image, 0.3f);
        //正确的做法是:通过上下文绘制一个新的图片可以解决进行图片选择的时候内存暴增的问题
        UIImage *resultImage = [self drawImageWithOriginalImage:[self compressImage:image] width:300];
        [self dismissViewControllerAnimated:YES completion:nil];
        if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_imagePickerController:didFinishPickingImage:)]){
            [self.swImagePickerDelegate sw_imagePickerController:picker didFinishPickingImage:resultImage];
        }
        if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_imagePickerController:didFinishPickingImage:userInfo:)]){
            [self.swImagePickerDelegate sw_imagePickerController:picker didFinishPickingImage:resultImage userInfo:picker.sw_imagePickerUserInfo];
        }
    }else if (picker.sw_PickerControllerMediaType == SWImagePickerControllerMediaTypeMovie){
        [self dismissViewControllerAnimated:YES completion:nil];
        if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_videoPickerController:didFinishPickingVideoInfo:)]){
            [self.swImagePickerDelegate sw_videoPickerController:picker didFinishPickingVideoInfo:info];
        }
        if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_videoPickerController:didFinishPickingVideoInfo:userInfo:)]){
            [self.swImagePickerDelegate sw_videoPickerController:picker didFinishPickingVideoInfo:info userInfo:picker.sw_imagePickerUserInfo];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_imagePickerControllerDidCancel:)]){
        [self.swImagePickerDelegate sw_imagePickerControllerDidCancel:picker];
    }
    if(self.swImagePickerDelegate && [self.swImagePickerDelegate respondsToSelector:@selector(sw_imagePickerControllerDidCancel:userInfo:)]){
        [self.swImagePickerDelegate sw_imagePickerControllerDidCancel:picker userInfo:((SWImagePickerController *)picker).sw_imagePickerUserInfo];
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

//压缩图片至100k以下
- (UIImage *)compressImage:(UIImage *)originalImage {
    NSData *data = UIImageJPEGRepresentation(originalImage, 1.0f);
    if(data.length > 100*1024){
        if(data.length > 1024*1024){
            data = UIImageJPEGRepresentation(originalImage, 0.1f);
        }else if (data.length > 512*1024){
            data = UIImageJPEGRepresentation(originalImage, 0.5f);
        }else if (data.length > 200*1024){
            data = UIImageJPEGRepresentation(originalImage, 0.9f);
        }
    }
    return [[UIImage alloc] initWithData:data];
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
