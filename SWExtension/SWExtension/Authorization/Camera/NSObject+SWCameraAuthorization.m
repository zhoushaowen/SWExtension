//
//  NSObject+SWCameraAuthorization.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "NSObject+SWCameraAuthorization.h"
#import <AVFoundation/AVFoundation.h>

static NSString *const LocalizedTableName = @"SWCameraAuthorization";

@implementation NSObject (SWCameraAuthorization)

+ (void)requestCameraAuthorizationWithCompletion:(void(^ _Nullable)(BOOL isAuthorized))completedBlock alertViewController:(UIViewController *_Nullable)alertViewController {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"有相机权限");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(YES);
                    }
                });
            }else{
                NSLog(@"没有相机权限");
                [self showCameraAuthorizationAlertWithTitle:                NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getCameraAuthorizationBundle], nil) alertViewController:alertViewController];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(NO);
                    }
                });
            }
        }];
    }else if (status == AVAuthorizationStatusAuthorized){
        NSLog(@"有相机权限");
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(YES);
            }
        });
    }else{
        NSLog(@"没有相机权限");
        [self showCameraAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getCameraAuthorizationBundle], nil) alertViewController:alertViewController];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(NO);
            }
        });
    }
}

+ (BOOL)sw_isHaveCameraAuthorizationWithAlertViewController:(UIViewController *_Nullable)alertViewController
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied)
    {
        [self showCameraAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getCameraAuthorizationBundle], nil) alertViewController:alertViewController];
        return NO;
    }
    
    return YES;
}

+ (void)showCameraAuthorizationAlertWithTitle:(NSString *)title alertViewController:(UIViewController *)alertViewController {
    if(alertViewController == nil) return;
    NSDictionary *dic = [NSBundle mainBundle].infoDictionary;
    NSString *appName = dic[@"CFBundleDisplayName"];
    if(!appName)
    {
        appName = dic[@"CFBundleName"];
    }
    [self openCameraAuthorizationSettingWithTitle:title message:[NSLocalizedStringFromTableInBundle(@"Message", LocalizedTableName, [self getCameraAuthorizationBundle], nil) stringByReplacingOccurrencesOfString:@"XXX" withString:appName] alertViewController:alertViewController];
}

+ (NSBundle *)getCameraAuthorizationBundle {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"SWCameraAuthorization.bundle" ofType:nil]];
    return bundle;
}

+ (void)openCameraAuthorizationSettingWithTitle:(NSString *)title message:(NSString *)message alertViewController:(UIViewController *)alertViewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Cancel", LocalizedTableName, [self getCameraAuthorizationBundle], nil) style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Set", LocalizedTableName, [self getCameraAuthorizationBundle], nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }]];
        [alertViewController presentViewController:alertController animated:YES completion:nil];
    });
}

@end
