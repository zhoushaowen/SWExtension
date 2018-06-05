//
//  ArrayAndDictionaryChineseOutputController.m
//  SWExtension
//
//  Created by zhoushaowen on 2018/6/5.
//  Copyright © 2018年 yidu. All rights reserved.
//

#import "ArrayAndDictionaryChineseOutputController.h"

@interface ArrayAndDictionaryChineseOutputController ()

@end

@implementation ArrayAndDictionaryChineseOutputController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[
                     @"数组里面的数据1",
                     @"数组里面的数据2",
                     @"数组里面的数据3",
                     @"数组里面的数据4",
                     @"数组里面的数据5",
                     @"数组里面的数据6",
                     ];
    NSDictionary *dic = @{
                     @"键1":@"字典数值1",
                     @"键2":@"字典数值2"
                     };
    NSLog(@"%@",arr);
    NSLog(@"%@",dic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
