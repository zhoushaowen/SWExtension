//
//  NSObject+SWMethodChange.h
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SWMethodChange)

+ (void)sw_exchangeMethodWithSystemSelector:(SEL)systemSel customSelector:(SEL)customSel;

@end

NS_ASSUME_NONNULL_END
