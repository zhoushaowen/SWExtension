//
//  UIButton+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/5/8.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SWExtension)

/**
 当按下按钮的时候,禁止按钮改变image的状态,默认是NO
 */
@property (nonatomic) BOOL sw_disableAdjustImageWhenTouchDown;

@end
