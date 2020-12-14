//
//  NSObject+SWMethodChange.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "NSObject+SWMethodChange.h"
#import <objc/runtime.h>

@implementation NSObject (SWMethodChange)


+ (void)sw_exchangeMethodWithSystemSelector:(SEL)systemSel customSelector:(SEL)customSel {
    Method systemMethod = class_getInstanceMethod([self class], systemSel);
    Method customMethod = class_getInstanceMethod([self class], customSel);
    if(class_addMethod([self class], systemSel, method_getImplementation(customMethod), method_getTypeEncoding(customMethod))){
        class_replaceMethod([self class], customSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
}

@end
