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
- (void)sw_imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image userInfo:(id)userInfo;
- (void)sw_videoPickerController:(UIImagePickerController *)picker didFinishPickingVideoInfo:(NSDictionary<NSString *,id> *)videoInfo userInfo:(id)userInfo;
- (void)sw_imagePickerControllerDidCancel:(UIImagePickerController *)picker userInfo:(id)userInfo;

- (void)sw_imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image __deprecated_msg("Use 'sw_imagePickerController:didFinishPickingImage:userInfo:'");
- (void)sw_videoPickerController:(UIImagePickerController *)picker didFinishPickingVideoInfo:(NSDictionary<NSString *,id> *)videoInfo __deprecated_msg("Use 'sw_videoPickerController:didFinishPickingVideoInfo:userInfo:'");
- (void)sw_imagePickerControllerDidCancel:(UIImagePickerController *)picker __deprecated_msg("Use 'sw_imagePickerControllerDidCancel:userInfo:'");

@end

@interface UIViewController (SWImagePicker)

- (void)sw_presentImagePickerControllerWithSourceType:
(UIImagePickerControllerSourceType)sourceType config:
(void(^)(UIImagePickerController *picker))config delegate:
(id<SWImagePickerControllerDelegate>)delegate userInfo:
(id)userInfo;

- (void)sw_presentVideoPickerControllerWithSourceType:
(UIImagePickerControllerSourceType)sourceType config:
(void(^)(UIImagePickerController *picker))config delegate:
(id<SWImagePickerControllerDelegate>)delegate userInfo:
(id)userInfo;

/**
 弹出照片选择器 allowsEditing NO
 
 @param sourceType 资源类型
 @param delegate 代理
 @return 照片选择器
 */
- (UIImagePickerController *)sw_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate userInfo:(id)userInfo __deprecated;

- (UIImagePickerController *)sw_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType isAllowsEditing:(BOOL)allowsEditing delegate:(id<SWImagePickerControllerDelegate>)delegate userInfo:(id)userInfo __deprecated;

/**
 弹出视频选择
 
 @param sourceType 资源类型
 @param delegate 代理
 @return 选择器
 */
- (UIImagePickerController *)sw_presentVideoPickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate userInfo:(id)userInfo __deprecated;

/**
 弹出照片选择器

 @param sourceType 资源类型
 @param delegate 代理
 @return 照片选择器
 */
- (UIImagePickerController *)sw_presentImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate __deprecated_msg("Use 'sw_presentImagePickerControllerWithSourceType:delegate:userInfo:'");

/**
 弹出视频选择

 @param sourceType 资源类型
 @param delegate 代理
 @return 选择器
 */
- (UIImagePickerController *)sw_presentVideoPickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType delegate:(id<SWImagePickerControllerDelegate>)delegate __deprecated_msg("Use 'sw_presentVideoPickerControllerWithSourceType:delegate:userInfo:'");

@end
