//
//  NSObject+SWExtensionMJ.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/11/27.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "NSObject+SWExtensionMJ.h"
#import <SWExtension.h>

@implementation NSObject (SWExtensionMJ)

+ (instancetype)sw_modelWithKeyValues:(id)keyValues {
//    if(keyValues == nil) return nil;
    id model = [self mj_objectWithKeyValues:keyValues];
    NSMutableDictionary *dic = [keyValues mj_JSONObject];
    //下面的做法是为了解决json序列化导致服务端返回的浮点数精度丢失的问题
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[NSNumber class]]){
            [self mj_enumerateProperties:^(MJProperty *property, BOOL *stop2) {
                if([property.name isEqualToString:[NSString stringWithFormat:@"%@",key]]){
                    if(property.type.typeClass == [NSNumber class]){
                        NSString *str = [NSString sw_fixAccuracyWithString:[obj stringValue]];
                        [model setValue:[NSDecimalNumber decimalNumberWithString:str] forKey:key];
                    }
                    else if (property.type.typeClass == [NSString class]){
                        NSString *str = [NSString sw_fixAccuracyWithString:[obj stringValue]];
                        [model setValue:str forKey:key];
                    }
                    *stop2 = YES;
                }
            }];

        }
    }];
    return model;
}


@end
