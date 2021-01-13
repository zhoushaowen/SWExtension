//
//  UITableView+SWCacheExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/12.
//  Copyright © 2021 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SWCacheExtension)

- (void)sw_setRowHeight:(CGFloat)rowHeight forIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)sw_rowHeightForIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
