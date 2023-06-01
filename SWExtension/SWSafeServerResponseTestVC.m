//
//  SWSafeServerResponseTestVC.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/9/28.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "SWSafeServerResponseTestVC.h"
#import <SWExtension/SWExtension.h>

@interface SWSafeServerResponseTestVC ()

@end

@implementation SWSafeServerResponseTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self test1];
    [self test2];
}

- (void)test1 {
    NSNull *null = [NSNull null];
    NSArray *arr0 = (NSArray *)null;
    NSLog(@"%@",[arr0 objectAtIndex:1]);
    NSDictionary *dic = @"1";
    NSLog(@"%@",dic[@"a"]);
    NSArray *arr = @"1";
    NSLog(@"%@",arr[1]);
    NSLog(@"%@",[arr objectAtIndex:2]);
    NSLog(@"%@",arr.firstObject);
    NSNumber *number = @[];
    NSLog(@"%@",[number intValue]);
    NSString *str = @{};
    NSLog(@"%@",str.length);
    NSLog(@"%@",[str respondsToSelector:@selector(length)] ? @"YES":@"NO");
    [arr.sw_safeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    [dic.sw_safeDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];
}

- (void)test2 {
    NSDictionary *dic = @{@"a":@"123"};
    NSLog(@"%@",dic[@"a"]);
    NSArray *arr = @[@"你好",@"世界",@"测试"];
    NSLog(@"%@",arr[1]);
    NSLog(@"%@",[arr objectAtIndex:2]);
    NSLog(@"%@",arr.firstObject);
}



@end
