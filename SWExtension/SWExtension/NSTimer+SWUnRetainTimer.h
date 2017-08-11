//
//  NSTimer+SWUnRetainTimer.h
//  Loko_iOS
//
//  Created by zhoushaowen on 2017/8/11.
//  Copyright © 2017年 loko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SWUnRetainTimer)

+ (NSTimer *)sw_scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void(^)(NSTimer *timer))block repeats:(BOOL)yesOrNo;
+ (NSTimer *)sw_timerWithTimeInterval:(NSTimeInterval)ti block:(void(^)(NSTimer *timer))block repeats:(BOOL)yesOrNo;

@end
