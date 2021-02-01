//
//  TestMainWindowController.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/28.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "TestMainWindowController.h"
#import <SWExtension.h>

@interface TestMainWindowController ()
{
    UIWindow *_window;
}
@end

@implementation TestMainWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@-------%@",[UIApplication sw_mainWindow],[UIApplication sharedApplication].keyWindow);
    
    _window = [[UIWindow alloc] initWithFrame:CGRectMake(20, 200, 40, 40)];
    _window.backgroundColor = [UIColor blackColor];
    _window.rootViewController = [UIViewController new];
//    [self.view addSubview:_window];
//    _window.hidden = NO;
    [_window makeKeyAndVisible];
    NSLog(@"%@-------%@",[UIApplication sw_mainWindow],[UIApplication sharedApplication].keyWindow);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIApplication sw_callPhoneNumber:@"17606522058"];
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
