//
//  ViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "ViewController.h"
#import <SWExtension.h>

@interface ViewController ()<SWImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UIAlertActionStyle arr[2] = {UIAlertActionStyleDefault,UIAlertActionStyleDestructive};
//    [self sw_presentAlertWithActionTitles:@[@"取消",@"确定"] styleArray:arr alertTitle:@"温馨提示" alertMessage:nil handler:^(UIAlertAction *action) {
//
//    } completion:^{
//
//    }];
//    [self sw_presentTextFieldAlertWithAlertTitle:@"esdsfsf" alertMessgae:@"sfesfs" actionTitles:@[@"ewdw",@"dwd"] styleArray:NULL textFieldConfigurationHandler:^(UITextField *textField) {
//        textField.textColor = [UIColor redColor];
//    } handler:^(UIAlertAction *action) {
//
//    } completion:^{
//
//    }];
//    [self sw_presentActionSheetWithSheetTitle:@"edwdddw" sheetMessgae:@"sefsfs" actionTitles:@[@"edsfsf",@"esfsfsf"] styleArray:arr cancelActionTitle:@"sdcssds" handler:^(UIAlertAction *action) {
//
//    } completion:^{
//
//    }];
    [self sw_presentImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary delegate:self userInfo:@123];
}

- (void)sw_imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image userInfo:(id)userInfo {
    NSLog(@"-------%@",userInfo);
}

- (void)sw_imagePickerControllerDidCancel:(UIImagePickerController *)picker userInfo:(id)userInfo {
    NSLog(@"+++++++%@",userInfo);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
