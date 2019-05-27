//
//  NSObject+SWMicrophoneAuthorization.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "NSObject+SWMicrophoneAuthorization.h"
#import <AVFoundation/AVFoundation.h>

static NSString *const LocalizedTableName = @"SWMicrophoneAuthorization";

@implementation NSObject (SWMicrophoneAuthorization)

+ (void)requestMicrophoneAuthorizationWithCompletion:(void(^ _Nullable)(BOOL isAuthorized))completedBlock alertViewController:(UIViewController *_Nullable)alertViewController {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    //AVAuthorizationStatusRestricted,未授权，且用户无法更新，如家长控制情况下
    //AVAuthorizationStatusDenied,用户已经明确否决
    if(status == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"有麦克风权限");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(YES);
                    }
                });
            }else{
                NSLog(@"没有麦克风权限");
                [self showMicrophoneAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getMicrophoneAuthorizationBundle], nil) alertViewController:alertViewController];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(NO);
                    }
                });
            }
        }];
    }else if (status == AVAuthorizationStatusAuthorized){
        NSLog(@"有麦克风权限");
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(YES);
            }
        });
    }else{
        NSLog(@"没有麦克风权限");
        [self showMicrophoneAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getMicrophoneAuthorizationBundle], nil) alertViewController:alertViewController];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(NO);
            }
        });
    }
}

+ (void)showMicrophoneAuthorizationAlertWithTitle:(NSString *)title alertViewController:(UIViewController *)alertViewController {
    if(alertViewController == nil) return;
    NSDictionary *dic = [NSBundle mainBundle].infoDictionary;
    NSString *appName = dic[@"CFBundleDisplayName"];
    if(!appName)
    {
        appName = dic[@"CFBundleName"];
    }
    [self openMicrophoneAuthorizationSettingWithTitle:title message:[NSLocalizedStringFromTableInBundle(@"Message", LocalizedTableName, [self getMicrophoneAuthorizationBundle], nil) stringByReplacingOccurrencesOfString:@"XXX" withString:appName] alertViewController:alertViewController];
}

+ (NSBundle *)getMicrophoneAuthorizationBundle {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"SWMicrophoneAuthorization.bundle" ofType:nil]];
    return bundle;
}

+ (void)openMicrophoneAuthorizationSettingWithTitle:(NSString *)title message:(NSString *)message alertViewController:(UIViewController *)alertViewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Cancel", LocalizedTableName, [self getMicrophoneAuthorizationBundle], nil) style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Set", LocalizedTableName, [self getMicrophoneAuthorizationBundle], nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
