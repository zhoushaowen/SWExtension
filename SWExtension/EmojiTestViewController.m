//
//  EmojiTestViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/3/12.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "EmojiTestViewController.h"
#import <NSString+SWEmoji.h>

@interface EmojiTestViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation EmojiTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textView.delegate = self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text sw_isContainEmojiString]) return NO;
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
