//
//  TestNSArrayExtensionController.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/10/16.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "TestNSArrayExtensionController.h"
#import <SWExtension.h>

@interface TestNSArrayExtensionController ()

@end

@implementation TestNSArrayExtensionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array1 = @[@"1",@1,@2,@2,@"3",@"3"];
    NSArray *results = [array1 sw_removeDuplicatesByKey:nil];
    NSLog(@"%@",results);
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
