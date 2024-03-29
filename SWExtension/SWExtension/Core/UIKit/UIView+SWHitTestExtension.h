//
//  UIView+SWHitTestExtension.h
//  hitTest
//
//  Created by zhoushaowen on 2021/1/25.
//  Copyright © 2021 WanHang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SWHitTestExtension)

@property (nonatomic,strong,nullable) UIView *(^sw_hitTestTargetView)(CGPoint point,UIEvent *event,UIView *originalTargetView);



@end

NS_ASSUME_NONNULL_END
