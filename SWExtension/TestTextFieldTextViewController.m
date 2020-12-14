//
//  TestTextFieldTextViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "TestTextFieldTextViewController.h"
#import <SWExtension.h>

@interface TestTextFieldTextViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TestTextFieldTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tf.sw_textDidChangeBlock = ^(UITextField * _Nonnull tf) {
        NSLog(@"1---%@",tf.text);
    };
    self.textView.sw_textDidChangeBlock = ^(UITextView * _Nonnull tv) {
        NSLog(@"2---%@",tv.text);
    };
    
    UITextView *tv2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 400, 100, 80)];
    tv2.backgroundColor = [UIColor redColor];
    [self.view addSubview:tv2];
    tv2.sw_textDidChangeBlock = ^(UITextView * _Nonnull tv) {
        NSLog(@"3---%@",tv.text);
    };
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
