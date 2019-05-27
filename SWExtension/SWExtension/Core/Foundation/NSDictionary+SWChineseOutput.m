//
//  NSDictionary+SWChineseOutput.m
//  Loko_iOS
//
//  Created by zhoushaowen on 2017/8/18.
//  Copyright © 2017年 loko. All rights reserved.
//

#import "NSDictionary+SWChineseOutput.h"

@implementation NSDictionary (SWChineseOutput)

//重写系统方法
#if SWEnableDictionaryChineseOutput
- (NSString *)descriptionWithLocale:(id)locale
{
    return [self chineseStr];
}
#endif

#if SWEnableDictionaryChineseOutput
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self chineseStr];
}
#endif

- (NSString *)chineseStr {
    NSMutableString *msr = [NSMutableString string];
    [msr appendString:@"{"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [msr appendFormat:@"\n\t%@ = %@,",key,obj];
    }];
    //去掉最后一个逗号（,）
    if ([msr hasSuffix:@","]) {
        NSString *str = [msr substringToIndex:msr.length - 1];
        msr = [NSMutableString stringWithString:str?:@""];
    }
    [msr appendString:@"\n}"];
    return msr;
}

@end
