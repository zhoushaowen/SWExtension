//
//  CameraAuthorizationViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "CameraAuthorizationViewController.h"
#import <NSObject+SWCameraAuthorization.h>

@interface CameraAuthorizationViewController ()

@end

@implementation CameraAuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [NSObject requestCameraAuthorizationWithCompletion:^(BOOL isAuthorized) {
        
    } alertViewController:self];
}

@end
