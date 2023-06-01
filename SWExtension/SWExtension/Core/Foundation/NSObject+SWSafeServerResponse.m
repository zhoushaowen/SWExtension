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

@implementation NSObject (SWSafeServerResponse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self sw_exchangeMethodWithSystemSelector:@selector(methodSignatureForSelector:) customSelector:@selector(sw_methodSignatureForSelector:)];
        [self sw_exchangeMethodWithSystemSelector:@selector(forwardInvocation:) customSelector:@selector(sw_forwardInvocation:)];

    });
}

#pragma mark - 防止对服务器返回非数组类型的对象执行取值操作导致的crash
- (NSMethodSignature *)sw_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [self sw_methodSignatureForSelector:aSelector];
    if(signature == nil){
        NSArray *classArray = @[[NSMutableArray class],[NSMutableDictionary class],[NSNumber class],[NSMutableString class],[NSDate class]];
        for(Class class in classArray){
            if([class instancesRespondToSelector:aSelector]){
                signature = [class instanceMethodSignatureForSelector:aSelector];
                NSLog(@"⚠️warning: %@没有实现%@方法!!!",[self class],NSStringFromSelector(aSelector));
                return signature;
            }
        }
    }
    return signature;
}

- (void)sw_forwardInvocation:(NSInvocation *)anInvocation {
    NSArray *classArray = @[[NSMutableArray class],[NSMutableDictionary class],[NSNumber class],[NSMutableString class],[NSDate class]];
    for(Class class in classArray){
        if([class instanceMethodForSelector:anInvocation.selector] && [class instanceMethodSignatureForSelector:anInvocation.selector] == anInvocation.methodSignature){
            anInvocation.target = nil;
            [anInvocation invoke];
            return;
        }
    }
    [self sw_forwardInvocation:anInvocation];

}


- (NSArray *)sw_safeArray {
    if([self isKindOfClass:[NSArray class]]) return (NSArray *)self;
    return nil;
}
- (NSDictionary *)sw_safeDictionary {
    if([self isKindOfClass:[NSDictionary class]]) return (NSDictionary *)self;
    return nil;
}
@end
