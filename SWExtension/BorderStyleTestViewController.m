//
//  BorderStyleTestViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/4/1.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "BorderStyleTestViewController.h"
#import <UIView+SWBorderStyle.h>

@interface BorderStyleTestViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation BorderStyleTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view1.sw_borderTopWidth = 0.5;
    self.view1.sw_borderLeftWidth = 0.5;
    self.view1.sw_borderBottomWidth = 0.5;
    self.view1.sw_borderRightWidth = 0.5;
    
    self.view2.sw_borderTopWidth = 0.5;
    self.view2.sw_borderLeftWidth = 0.5;
    self.view2.sw_borderBottomWidth = 0.5;
    self.view2.sw_borderRightWidth = 0.5;
    
    self.view2.sw_insetsForBorderTop = UIEdgeInsetsMake(8, 8, 0, 8);
    self.view2.sw_insetsForBorderLeft = UIEdgeInsetsMake(8, 8, 8, 0);
    self.view2.sw_insetsForBorderBottom = UIEdgeInsetsMake(0, 8, 8, 8);
    self.view2.sw_insetsForBorderRight = UIEdgeInsetsMake(8, 0, 8, 8);
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
