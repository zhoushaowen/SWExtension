//
//  CALayer+SWExtension.h
//  Pods
//
//  Created by zhoushaowen on 2020/9/10.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (SWExtension)

@property(nonatomic,strong) UIColor *sw_borderUIColor;
@property(nonatomic,strong) UIColor *sw_shadowUIColor;

@end

NS_ASSUME_NONNULL_END
