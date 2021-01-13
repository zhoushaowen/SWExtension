//
//  NSObject+SWSafeServerResponse.m
//  BSPCN
//
//  Created by zhoushaowen on 2019/4/16.
//  Copyright © 2019 Vincent. All rights reserved.
//

#import "NSObject+SWSafeServerResponse.h"
#import <objc/runtime.h>
#import "NSObject+SWMethodChange.h"

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
        [self sw_exchangeMethodWithSystemSelector:@selector(forwardingTargetForSelector:) customSelector:@selector(sw_forwardingTargetForSelector:)];
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
