//
//  SingletonTestViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2019/12/3.
//  Copyright © 2019 yidu. All rights reserved.
//

#import "SingletonTestViewController.h"
#import "MyUtil.h"

@interface SingletonTestViewController ()

@end

@implementation SingletonTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
//    NSLog(@"%@",[[MyUtil sharedInstance] copy]);
//    NSLog(@"%@",[[MyUtil sharedInstance] copy]);
//    NSLog(@"%@",[[MyUtil sharedInstance] copy]);
    [MyUtil destroyInstance];
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
    NSLog(@"%@",[MyUtil sharedInstance]);
//    NSLog(@"%@",[[MyUtil sharedInstance] copy]);
//    NSLog(@"%@",[[MyUtil sharedInstance] copy]);
//    NSLog(@"%@",[[MyUtil sharedInstance] copy]);

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
