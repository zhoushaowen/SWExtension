//
//  UITableView+SWEmptyView.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SWEmptyView)

/**
 用于当数位为空的时候,tableView显示的view
 */
@property (nonatomic,strong) UIView *sw_emptyView;

/**
 显示设置的view
 */
- (void)sw_showEmptyView;

/**
 隐藏设置的view
 */
- (void)sw_hideEmptyView;

@end
