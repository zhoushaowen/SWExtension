//
//  TestSWGestureAddController.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "TestSWGestureAddController.h"
#import <SWExtension.h>

@interface TestSWGestureAddController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation TestSWGestureAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.view sw_addGestureRecognizer:[UITapGestureRecognizer new] withActionBlock:^(UIGestureRecognizer *gestureRecognizer) {
//        NSLog(@"gestureRecognizer1:%@",gestureRecognizer);
//    }];
    [self.view sw_addTapGestureRecognizerWithActionBlock:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
        NSLog(@"gestureRecognizer0:%@",gestureRecognizer);
    } gestureRecognizerShouldReceiveTouch:nil];
    [self.redView sw_addGestureRecognizer:[UITapGestureRecognizer new] withActionBlock:^(UIGestureRecognizer *gestureRecognizer) {
        NSLog(@"gestureRecognizer2:%@",gestureRecognizer);
    }];
    
    for(int i=0;i<10;i++){
        [self.blueView sw_tapGestureRecognizerWithActionBlock:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
            NSLog(@"gestureRecognizer3:%@",gestureRecognizer);
        }];
    }
    
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
