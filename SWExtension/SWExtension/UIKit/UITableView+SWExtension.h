//
//  UITableView+SWExtension.h
//  Pods-SWExtension
//
//  Created by zhoushaowen on 2018/11/19.
//

#import <UIKit/UIKit.h>


@interface UITableView (SWExtension)

- (void)sw_registerCellWithClass:(Class _Nonnull)cellClass;
- (void)sw_registerHeaderFooterViewWithClass:(Class _Nonnull)aClass;
- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle;
- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName;
- (void)sw_registerHeaderFooterViewWithNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle;
- (void)sw_registerHeaderFooterViewWithNibName:(NSString *_Nonnull)nibName;
- (UITableViewCell *)sw_dequeueReusableCellWithClass:(Class _Nonnull)cellClass;
- (UITableViewCell *)sw_dequeueReusableCellWithClass:(Class _Nonnull)cellClass forIndexPath:(NSIndexPath *)indexPath;
- (UITableViewHeaderFooterView *)sw_dequeueReusableHeaderFooterViewWithClass:(Class _Nonnull)aClass;


@end

