//
//  NSArray+SWChineseOutput.m
//  Loko_iOS
//
//  Created by zhoushaowen on 2017/8/18.
//  Copyright © 2017年 loko. All rights reserved.
//

#import "NSArray+SWChineseOutput.h"

@implementation NSArray (SWChineseOutput)

//重写系统方法
#if SWEnableArrayChineseOutput
- (NSString *)descriptionWithLocale:(id)locale
{
    return [self chineseStr];
}
#endif

#if SWEnableArrayChineseOutput
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self chineseStr];
}
#endif

- (NSString *)chineseStr {
    NSMutableString *msr = [NSMutableString string];
    [msr appendString:@"["];
    for (id obj in self) {
        [msr appendFormat:@"\n\t%@,",obj];
    }
    //去掉最后一个逗号（,）
    if ([msr hasSuffix:@","]) {
        NSString *str = [msr substringToIndex:msr.length - 1];
        msr = [NSMutableString stringWithString:str];
    }
    [msr appendString:@"\n]"];
    return msr;
}

@end
