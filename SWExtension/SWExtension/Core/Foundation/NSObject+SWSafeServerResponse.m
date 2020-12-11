//
//  NSObject+SWSafeServerResponse.m
//  BSPCN
//
//  Created by zhoushaowen on 2019/4/16.
//  Copyright © 2019 Vincent. All rights reserved.
//

#import "NSObject+SWSafeServerResponse.h"
#import <objc/runtime.h>

@interface SWSafeServerResponseReceiver : NSObject

- (id)objectForKey:(id)key;
- (id)objectForKeyedSubscript:(id)key;
- (id)objectAtIndexedSubscript:(NSInteger)index;
- (id)objectAtIndex:(NSInteger)index;
- (id)firstObject;
- (id)lastObject;

@end

@implementation SWSafeServerResponseReceiver


- (id)objectForKey:(id)key {
    return nil;
}

- (id)objectForKeyedSubscript:(id)key {
    return nil;
}

- (id)objectAtIndexedSubscript:(NSInteger)index {
    return nil;
}

- (id)objectAtIndex:(NSInteger)index {
    return nil;
}

- (id)firstObject {
    return nil;
}

- (id)lastObject {
    return nil;
}

@end

@implementation NSObject (SWSafeServerResponse)

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
//        Method sysMethod2 = class_getInstanceMethod([self class], @selector(methodSignatureForSelector:));
//        Method myMethod2 = class_getInstanceMethod([self class], @selector(sw_methodSignatureForSelector:));
//        if(class_addMethod([self class], @selector(methodSignatureForSelector:), method_getImplementation(myMethod2), method_getTypeEncoding(myMethod2))){
//            class_replaceMethod([self class], @selector(sw_methodSignatureForSelector:), method_getImplementation(sysMethod2), method_getTypeEncoding(sysMethod2));
//        }else{
//            method_exchangeImplementations(sysMethod2, myMethod2);
//        }
    });
}

#pragma mark - 防止对服务器返回非数组类型的对象执行取值操作导致的crash
- (id)sw_forwardingTargetForSelector:(SEL)aSelector {
    if(aSelector == @selector(objectForKey:) ||
       aSelector == NSSelectorFromString(@"objectForKeyedSubscript:") ||
       aSelector == NSSelectorFromString(@"objectAtIndexedSubscript:") ||
       aSelector == @selector(objectAtIndex:) ||
       aSelector == @selector(firstObject) ||
       aSelector == @selector(lastObject) 
       ){
        NSLog(@"%@没有实现%@方法",[self class],NSStringFromSelector(aSelector));
        //接盘侠
        return [[SWSafeServerResponseReceiver alloc] init];
    }
    return [self sw_forwardingTargetForSelector:aSelector];
}

//- (NSMethodSignature *)sw_methodSignatureForSelector:(SEL)aSelector {
//    if(aSelector == @selector(objectForKey:) ||
//       aSelector == NSSelectorFromString(@"objectForKeyedSubscript:") ||
//       aSelector == NSSelectorFromString(@"objectAtIndexedSubscript:") ||
//       aSelector == @selector(objectAtIndex:)
//       ){
//        return [NSMethodSignature signatureWithObjCTypes:"@@:@"];
//    }
//    return [self sw_methodSignatureForSelector:aSelector];
//}

//#pragma mark - 避免操作数组crash的方法
//- (id)sw_safe_objectAtIndex:(NSUInteger)index {
//    if(index > self.count - 1){
//        return nil;
//    }
//    if(self.count == 0) return nil;
//    return [self objectAtIndex:index];
//}

@end
