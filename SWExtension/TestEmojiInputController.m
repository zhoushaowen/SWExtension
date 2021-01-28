//
//  TestEmojiInputController.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/27.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "TestEmojiInputController.h"
#import <SWExtension.h>

@interface TestEmojiInputController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TestEmojiInputController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textView.delegate = self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text sw_isContainEmojiString]) {
        return NO;
    }
    return YES;
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
