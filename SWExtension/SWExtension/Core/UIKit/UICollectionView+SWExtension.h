//
//  UICollectionView+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2018/11/28.
//  Copyright © 2018 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UICollectionView (SWExtension)

- (void)sw_registerCellWithClass:(Class _Nonnull)cellClass;
- (void)sw_registerClass:(Class _Nonnull)aClass forSupplementaryViewOfKind:(NSString *)elementKind;
- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle;
- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName;
- (void)sw_registerNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle forSupplementaryViewOfKind:(NSString *)elementKind;
- (void)sw_registerNibName:(NSString *_Nonnull)nibName forSupplementaryViewOfKind:(NSString *)elementKind;
- (__kindof UICollectionViewCell *)sw_dequeueReusableCellWithClass:(Class _Nonnull)cellClass forIndexPath:(NSIndexPath *)indexPath;
- (__kindof UICollectionReusableView *)sw_dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withClass:(Class _Nonnull)aClass forIndexPath:(NSIndexPath *)indexPath;


@end

