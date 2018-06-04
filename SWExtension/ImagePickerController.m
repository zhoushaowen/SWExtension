//
//  ImagePickerController.m
//  SWExtension
//
//  Created by zhoushaowen on 2018/6/4.
//  Copyright © 2018年 yidu. All rights reserved.
//

#import "ImagePickerController.h"
#import <UIViewController+SWImagePicker.h>

@interface ImagePickerController ()<SWImagePickerControllerDelegate>

@end

@implementation ImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sw_presentImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary delegate:self userInfo:@123];
}

- (void)sw_imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image userInfo:(id)userInfo {
    NSLog(@"-------%@",userInfo);
}

- (void)sw_imagePickerControllerDidCancel:(UIImagePickerController *)picker userInfo:(id)userInfo {
    NSLog(@"+++++++%@",userInfo);
}




@end
