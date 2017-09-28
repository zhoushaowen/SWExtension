//
//  UITableView+FitIOS11.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/9/27.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UITableView+FitIOS11.h"
#import <objc/runtime.h>

@implementation UITableView (FitIOS11)

- (void)sw_removeEstimatedHeight {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}


@end
