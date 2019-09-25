//
//  UIColor+SWExtension.m
//  CloudPharmacy
//
//  Created by zhoushaowen on 2019/9/23.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "UIColor+SWExtension.h"

@implementation UIColor (SWExtension)

+ (UIColor *)sw_colorWithDynamicProvider:(UIColor *_Nullable(^)(BOOL isDarkAppearance))dynamicProvider {
    if (@available(iOS 13.0, *)) {
#ifdef __IPHONE_13_0 //兼容低版本XCode
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
                return dynamicProvider(YES);
            }else{
                return dynamicProvider(NO);
            }
        }];
#else
        return dynamicProvider(NO);
#endif
    } else {
        // Fallback on earlier versions
        return dynamicProvider(NO);
    }
}


@end
