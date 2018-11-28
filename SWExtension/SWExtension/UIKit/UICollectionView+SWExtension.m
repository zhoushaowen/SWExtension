//
//  UICollectionView+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2018/11/28.
//  Copyright © 2018 yidu. All rights reserved.
//

#import "UICollectionView+SWExtension.h"

@implementation UICollectionView (SWExtension)


- (void)sw_registerCellWithClass:(Class _Nonnull)cellClass {
    [self registerClass:cellClass forCellWithReuseIdentifier:[self sw_getIdentifierWithClass:cellClass]];
}

- (void)sw_registerClass:(Class _Nonnull)aClass forSupplementaryViewOfKind:(NSString *)elementKind {
    [self registerClass:aClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:[self sw_getIdentifierWithClass:aClass]];
}

- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle {
    [self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forCellWithReuseIdentifier:[nibName stringByAppendingString:@"SWReuseIdentifier"]];
}

- (void)sw_registerCellWithNibName:(NSString *_Nonnull)nibName {
    [self sw_registerCellWithNibName:nibName bundle:nil];
}

- (void)sw_registerNibName:(NSString *_Nonnull)nibName bundle:(NSBundle *_Nullable)bundle forSupplementaryViewOfKind:(NSString *)elementKind {
    [self registerNib:[UINib nibWithNibName:nibName bundle:bundle] forSupplementaryViewOfKind:elementKind withReuseIdentifier:[nibName stringByAppendingString:@"SWReuseIdentifier"]];
}

- (void)sw_registerNibName:(NSString *_Nonnull)nibName forSupplementaryViewOfKind:(NSString *)elementKind {
    [self sw_registerNibName:nibName bundle:nil forSupplementaryViewOfKind:elementKind];
}

- (__kindof UICollectionViewCell *)sw_dequeueReusableCellWithClass:(Class _Nonnull)cellClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:[self sw_getIdentifierWithClass:cellClass] forIndexPath:indexPath];
}

- (__kindof UICollectionReusableView *)sw_dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withClass:(Class _Nonnull)aClass forIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:[self sw_getIdentifierWithClass:aClass] forIndexPath:indexPath];
}


- (NSString *)sw_getIdentifierWithClass:(Class _Nonnull)class {
    return [NSStringFromClass(class) stringByAppendingString:@"SWReuseIdentifier"];
}


@end
