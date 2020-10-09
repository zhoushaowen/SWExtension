//
//  TestVCExtensionController.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/9/29.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "TestVCExtensionController.h"
#import "TestVCExtensionController2.h"
#import <SWExtension.h>

@interface TestVCExtensionController ()

@end

@implementation TestVCExtensionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)presentAction:(id)sender {
    TestVCExtensionController2 *vc = [TestVCExtensionController2 new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    tabbarVC.viewControllers = @[nav];
    [self presentViewController:tabbarVC animated:YES completion:nil];

}
- (IBAction)present2Action:(id)sender {
    TestVCExtensionController2 *vc = [TestVCExtensionController2 new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)present3Action:(id)sender {
    TestVCExtensionController2 *vc = [TestVCExtensionController2 new];
    TestVCExtensionController2 *subVc = [TestVCExtensionController2 new];
    [vc.view addSubview:subVc.view];
    [vc addChildViewController:subVc];
    [subVc didMoveToParentViewController:vc];
    subVc.view.backgroundColor = [UIColor cyanColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
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
