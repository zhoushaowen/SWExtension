//
//  UIViewController+SWImagePicker.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/9.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWImagePickerControllerDelegate <NSObject>

@optional
- (void)sw_imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image;
- (void)sw_videoPickerController:(UIImagePickerController *)picker didFinishPickingVideoInfo:(NSDictionary<NSString *,id> *)videoInfo;
- (void)sw_imagePickerControllerDidCancel:(UIImagePickerController *)picker;

@end

@interface UIViewController (SWImagePicker)

/**
 弹出照片选择器

 @param sourceType 资源类型
 @param delegate 代理
 @return 照片选择器
 */
- (UIImagePickerController *)sw_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate;

/**
 弹出视频选择

 @param sourceType 资源类型
 @param delegate 代理
 @return 选择器
 */
- (UIImagePickerController *)sw_presentVideoPickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate;

@end
