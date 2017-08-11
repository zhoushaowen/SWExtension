//
//  NSTimer+SWUnRetainTimer.m
//  Loko_iOS
//
//  Created by zhoushaowen on 2017/8/11.
//  Copyright © 2017年 loko. All rights reserved.
//

#import "NSTimer+SWUnRetainTimer.h"

@implementation NSTimer (SWUnRetainTimer)

+ (NSTimer *)sw_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget block:(void(^)(NSTimer *timer))block repeats:(BOOL)yesOrNo {
    return [NSTimer timerWithTimeInterval:ti target:aTarget selector:@selector(sw_blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
}

+ (void)sw_blockInvoke:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    if(block){
        block(timer);
    }
}

@end
