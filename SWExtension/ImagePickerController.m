//
//  ImagePickerController.m
//  SWExtension
//
//  Created by zhoushaowen on 2018/6/4.
//  Copyright © 2018年 yidu. All rights reserved.
//

#import "ImagePickerController.h"
#import <UIViewController+SWImagePicker.h>
#import <UIView+SWExtension.h>
#import <SWExtension.h>
#import <ReactiveObjC.h>

@interface ImagePickerController ()<SWImagePickerControllerDelegate>


@end

@implementation ImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    [self.view sw_addGestureRecognizerWithClass:[UITapGestureRecognizer class] delegate:nil actionBlock:^(UIGestureRecognizer *gestureRecognizer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf sw_presentImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary delegate:strongSelf userInfo:@123];
    }];
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        NSLog(@"UIApplicationDidReceiveMemoryWarningNotification:%@",self);
    }];

}

- (void)sw_imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image userInfo:(id)userInfo {
    NSLog(@"-------%@",userInfo);
}

- (void)sw_imagePickerControllerDidCancel:(UIImagePickerController *)picker userInfo:(id)userInfo {
    NSLog(@"+++++++%@",userInfo);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
