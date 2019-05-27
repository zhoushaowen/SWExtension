//
//  NSObject+SWPhotoLibraryAuthorization.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "NSObject+SWPhotoLibraryAuthorization.h"
#import <Photos/Photos.h>

static NSString *const LocalizedTableName = @"SWPhotoLibraryAuthorization";

@implementation NSObject (SWPhotoLibraryAuthorization)

+ (void)requestPhotoLibraryAuthorizationWithCompletion:(void(^_Nullable)(BOOL isAuthorized))completedBlock alertViewController:(UIViewController *_Nullable)alertViewController {
    if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized){
                NSLog(@"有相册权限");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(YES);
                    }
                });
            }else{
                NSLog(@"没有相册权限");
                [self showPhotoLibraryAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getPhotoLibraryAuthorizationBundle], nil) alertViewController:alertViewController];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(NO);
                    }
                });
            }
        }];
    }else if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){
        NSLog(@"有相册权限");
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(YES);
            }
        });
    }else{
        NSLog(@"没有相册权限");
        [self showPhotoLibraryAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getPhotoLibraryAuthorizationBundle], nil) alertViewController:alertViewController];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(NO);
            }
        });
    }
}

+ (BOOL)sw_isHavePhotoLibarayAuthorizationWithAlertViewController:(UIViewController *_Nullable)alertViewController
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusRestricted ||status == PHAuthorizationStatusDenied)
    {
        [self showPhotoLibraryAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getPhotoLibraryAuthorizationBundle], nil) alertViewController:alertViewController];
        return NO;
    }
    
    return YES;
}

+ (void)showPhotoLibraryAuthorizationAlertWithTitle:(NSString *)title alertViewController:(UIViewController *)alertViewController {
    if(alertViewController == nil) return;
    NSDictionary *dic = [NSBundle mainBundle].infoDictionary;
    NSString *appName = dic[@"CFBundleDisplayName"];
    if(!appName)
    {
        appName = dic[@"CFBundleName"];
    }
    [self openPhotoLibraryAuthorizationSettingWithTitle:title message:[NSLocalizedStringFromTableInBundle(@"Message", LocalizedTableName, [self getPhotoLibraryAuthorizationBundle], nil) stringByReplacingOccurrencesOfString:@"XXX" withString:appName] alertViewController:alertViewController];
}

+ (NSBundle *)getPhotoLibraryAuthorizationBundle {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"SWPhotoLibraryAuthorization.bundle" ofType:nil]];
    return bundle;
}

+ (void)openPhotoLibraryAuthorizationSettingWithTitle:(NSString *)title message:(NSString *)message alertViewController:(UIViewController *)alertViewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Cancel", LocalizedTableName, [self getPhotoLibraryAuthorizationBundle], nil) style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Set", LocalizedTableName, [self getPhotoLibraryAuthorizationBundle], nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
