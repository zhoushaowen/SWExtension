//
//  TestAlertController.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/13.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "TestAlertController.h"
#import <SWExtension.h>

@interface TestAlertController ()

@end

@implementation TestAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self sw_presentAlertWithOnlyActionTitle:@"好" style:UIAlertActionStyleDefault alertTitle:@"测试标题" alertMessage:@"测试内容" handler:nil completion:nil];
}

- (IBAction)btn1Action:(UIButton *)sender {
    [self sw_presentAlertWithAttributedTitle:[[NSAttributedString alloc] initWithString:@"测试标题" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blueColor]}]  attributedMessage:[[NSAttributedString alloc] initWithString:@"测试内容" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}] actionTitles:@[@"确认",@"取消"]
                                actionStyles:nil
                           actionTitleColors:@[[UIColor purpleColor],[UIColor grayColor]] handler:^(SWAlertAction *action) {
        
    } completion:nil];
}
- (IBAction)btn2Action:(UIButton *)sender {
    [self sw_presentActionSheetWithAttributedTitle:[[NSAttributedString alloc] initWithString:@"测试标题" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blueColor]}]  attributedMessage:[[NSAttributedString alloc] initWithString:@"测试内容" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor redColor]}] actionTitles:@[@"确认",@"取消"]
                                actionStyles:@[@(UIAlertActionStyleDefault),@(UIAlertActionStyleCancel)]
                           actionTitleColors:@[[UIColor purpleColor],[UIColor grayColor]] handler:^(SWAlertAction *action) {
        
    } completion:nil];
}
- (IBAction)btn3Action:(UIButton *)sender {
    [self sw_presentActionSheetWithTitle:@"测试标题" message:@"测试内容" defaultActionTitles:@[@"确认"] cancelActionTitle:@"取消" defaultActionTitleColor:[UIColor redColor] cancelActionTitleColor:[UIColor grayColor] handler:^(SWAlertAction *action) {
        
    } completion:nil];
}
- (IBAction)btn4Action:(UIButton *)sender {
    [self sw_presentAlertWithTitle:@"测试标题" message:@"测试内容" titleColor:[UIColor redColor] messageColor:[UIColor blueColor] actionTitles:@[@"确认",@"取消"] actionStyles:nil actionTitleColors:@[[UIColor greenColor],[UIColor grayColor]] handler:^(SWAlertAction *action) {
        
    } completion:nil];
}

- (IBAction)btn5Action:(UIButton *)sender {
    [self sw_presentAlertWithTitle:@"测试标题" message:@"测试内容" titleColor:[UIColor redColor] messageColor:[UIColor blueColor] actionTitles:@[@"选项1",@"选项2",@"选项3"] actionStyles:nil actionTitleColors:@[[UIColor greenColor],[UIColor grayColor],[UIColor orangeColor]] handler:^(SWAlertAction *action) {
        
    } completion:nil];
}

- (IBAction)btn6Action:(UIButton *)sender {
    [self sw_presentActionSheetWithSheetTitle:@"测试标题" sheetMessgae:@"测试内容" actionTitles:@[@"确认"] styleArray:NULL cancelActionTitle:@"取消" handler:^(SWAlertAction *action) {

    } completion:nil];
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
