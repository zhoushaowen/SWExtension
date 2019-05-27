//
//  NSObject+SWSpeechRecognizerAuthorization.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "NSObject+SWSpeechRecognizerAuthorization.h"
#import <Speech/Speech.h>

static NSString *const LocalizedTableName = @"SWSpeechRecognizerAuthorization";

@implementation NSObject (SWSpeechRecognizerAuthorization)

+ (void)requestSpeechRecognizerAuthorizationWithCompletion:(void(^ _Nullable)(BOOL isAuthorized))completedBlock alertViewController:(UIViewController *_Nullable)alertViewController NS_AVAILABLE_IOS(10.0) {
    if([SFSpeechRecognizer authorizationStatus] == SFSpeechRecognizerAuthorizationStatusNotDetermined){
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            if(status == SFSpeechRecognizerAuthorizationStatusAuthorized){
                NSLog(@"有语音识别权限");
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(YES);
                    }
                });
            }else{
                NSLog(@"没有语音识别权限");
                [self showSpeechRecognizerAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getSpeechRecognizerAuthorizationBundle], nil) alertViewController:alertViewController];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completedBlock){
                        completedBlock(NO);
                    }
                });
            }
        }];
    }else if ([SFSpeechRecognizer authorizationStatus] == SFSpeechRecognizerAuthorizationStatusAuthorized){
        NSLog(@"有语音识别权限");
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(YES);
            }
        });
    }else{
        NSLog(@"没有语音识别权限");
        [self showSpeechRecognizerAuthorizationAlertWithTitle:NSLocalizedStringFromTableInBundle(@"AlertTitle", LocalizedTableName, [self getSpeechRecognizerAuthorizationBundle], nil) alertViewController:alertViewController];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completedBlock){
                completedBlock(NO);
            }
        });
    }
}

+ (void)showSpeechRecognizerAuthorizationAlertWithTitle:(NSString *)title alertViewController:(UIViewController *)alertViewController {
    if(alertViewController == nil) return;
    NSDictionary *dic = [NSBundle mainBundle].infoDictionary;
    NSString *appName = dic[@"CFBundleDisplayName"];
    if(!appName)
    {
        appName = dic[@"CFBundleName"];
    }
    [self openSpeechRecognizerAuthorizationSettingWithTitle:title message:[NSLocalizedStringFromTableInBundle(@"Message", LocalizedTableName, [self getSpeechRecognizerAuthorizationBundle], nil) stringByReplacingOccurrencesOfString:@"XXX" withString:appName] alertViewController:alertViewController];
}

+ (NSBundle *)getSpeechRecognizerAuthorizationBundle {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"SWSpeechRecognizerAuthorization.bundle" ofType:nil]];
    return bundle;
}

+ (void)openSpeechRecognizerAuthorizationSettingWithTitle:(NSString *)title message:(NSString *)message alertViewController:(UIViewController *)alertViewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Cancel", LocalizedTableName, [self getSpeechRecognizerAuthorizationBundle], nil) style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Set", LocalizedTableName, [self getSpeechRecognizerAuthorizationBundle], nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
