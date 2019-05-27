//
//  NSArray+SWSafe.m
//  BSPCN
//
//  Created by zhoushaowen on 2019/4/16.
//  Copyright © 2019 Vincent. All rights reserved.
//

#import "NSArray+SWSafe.h"
#import <objc/runtime.h>

@interface SWArraySafeReceiver : NSObject

- (id)objectForKey:(id)key;
- (id)objectForKeyedSubscript:(id)key;

@end

@implementation SWArraySafeReceiver


- (id)objectForKey:(id)key {
    return nil;
}

- (id)objectForKeyedSubscript:(id)key {
    return nil;
}


@end

@implementation NSArray (SWSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sysMethod1 = class_getInstanceMethod([self class], @selector(forwardingTargetForSelector:));
        Method myMethod1 = class_getInstanceMethod([self class], @selector(sw_forwardingTargetForSelector:));
        if(class_addMethod([self class], @selector(forwardingTargetForSelector:), method_getImplementation(myMethod1), method_getTypeEncoding(myMethod1))){
            class_replaceMethod([self class], @selector(sw_forwardingTargetForSelector:), method_getImplementation(sysMethod1), method_getTypeEncoding(sysMethod1));
        }else{
            method_exchangeImplementations(sysMethod1, myMethod1);
        }
        Method sysMethod2 = class_getInstanceMethod([self class], @selector(methodSignatureForSelector:));
        Method myMethod2 = class_getInstanceMethod([self class], @selector(sw_methodSignatureForSelector:));
        if(class_addMethod([self class], @selector(methodSignatureForSelector:), method_getImplementation(myMethod2), method_getTypeEncoding(myMethod2))){
            class_replaceMethod([self class], @selector(sw_methodSignatureForSelector:), method_getImplementation(sysMethod2), method_getTypeEncoding(sysMethod2));
        }else{
            method_exchangeImplementations(sysMethod2, myMethod2);
        }
    });
}


- (id)sw_forwardingTargetForSelector:(SEL)aSelector {
    if(aSelector == @selector(objectForKey:) || aSelector == NSSelectorFromString(@"objectForKeyedSubscript:")){
        NSLog(@"%@没有实现%@方法",self,NSStringFromSelector(aSelector));
        //接盘侠
        return [[SWArraySafeReceiver alloc] init];
    }
    return [self sw_forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)sw_methodSignatureForSelector:(SEL)aSelector {
    if(aSelector == @selector(objectForKey:) || aSelector == NSSelectorFromString(@"objectForKeyedSubscript:")){
        return [NSMethodSignature signatureWithObjCTypes:"@@:@"];
    }
    return [self sw_methodSignatureForSelector:aSelector];
}

@end
