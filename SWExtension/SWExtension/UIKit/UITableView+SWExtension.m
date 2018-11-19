//
//  UITableView+SWExtension.m
//  Pods-SWExtension
//
//  Created by zhoushaowen on 2018/11/19.
//

#import "UITableView+SWExtension.h"

@implementation UITableView (SWExtension)

- (void)sw_registerCellWithClass:(Class _Nonnull)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:[self sw_getIdentifierWithClass:cellClass]];
}

- (void)sw_registerHeaderFooterViewWithClass:(Class _Nonnull)aClass {
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:[self sw_getIdentifierWithClass:aClass]];
}

- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle {
    [self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forCellReuseIdentifier:[nibName stringByAppendingString:@"SWReuseIdentifier"]];
}

- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName {
    [self sw_registerCellWithNibName:nibName bundle:nil];
}

- (void)sw_registerHeaderFooterViewWithNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle  {
    [self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forHeaderFooterViewReuseIdentifier:[nibName stringByAppendingString:@"SWReuseIdentifier"]];
}

- (void)sw_registerHeaderFooterViewWithNibName:(NSString *_Nonnull)nibName {
    [self sw_registerHeaderFooterViewWithNibName:nibName bundle:nil];
}

- (UITableViewCell *)sw_dequeueReusableCellWithClass:(Class _Nonnull)cellClass {
    return [self dequeueReusableCellWithIdentifier:[self sw_getIdentifierWithClass:cellClass]];
}

- (UITableViewCell *)sw_dequeueReusableCellWithClass:(Class _Nonnull)cellClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithIdentifier:[self sw_getIdentifierWithClass:cellClass] forIndexPath:indexPath];
}

- (UITableViewHeaderFooterView *)sw_dequeueReusableHeaderFooterViewWithClass:(Class _Nonnull)aClass {
    return [self dequeueReusableHeaderFooterViewWithIdentifier:[self sw_getIdentifierWithClass:aClass]];
}

- (NSString *)sw_getIdentifierWithClass:(Class _Nonnull)class {
    return [NSStringFromClass(class) stringByAppendingString:@"SWReuseIdentifier"];
}

@end
