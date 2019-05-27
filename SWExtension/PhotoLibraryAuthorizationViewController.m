//
//  PhotoLibraryAuthorizationViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "PhotoLibraryAuthorizationViewController.h"
#import <NSObject+SWPhotoLibraryAuthorization.h>

@interface PhotoLibraryAuthorizationViewController ()

@end

@implementation PhotoLibraryAuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [NSObject requestPhotoLibraryAuthorizationWithCompletion:^(BOOL isAuthorized) {

    } alertViewController:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
