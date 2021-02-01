//
//  NSObject+SWExtensionMJ.m
//  SWExtension
//
//  Created by zhoushaowen on 2020/11/27.
//  Copyright © 2020 yidu. All rights reserved.
//

#import "NSObject+SWExtensionMJ.h"
#import "NSString+SWExtension.h"
#import <MJExtension/MJExtension.h>

@implementation NSObject (SWExtensionMJ)

+ (instancetype)sw_modelWithKeyValues:(id)keyValues {
    if(keyValues == nil) return nil;
    id model = [self mj_objectWithKeyValues:keyValues];
    NSMutableDictionary *dic = [keyValues mj_JSONObject];
    //下面的做法是为了解决json序列化导致服务端返回的浮点数精度丢失的问题
    [self __sw_fixModelFloatAccuracyWithModel:model dictionary:dic];
    return model;
}

+ (void)__sw_fixModelFloatAccuracyWithModel:(id)model dictionary:(NSDictionary *)dic {
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *valueKeyName = [NSString stringWithFormat:@"%@",key];
        __block MJProperty *property = nil;
        [self mj_enumerateProperties:^(MJProperty *aProperty, BOOL *stop2) {
            NSString *name = aProperty.name;
            //被替换之后的属性名
            NSString *replacedName = nil;
            if([self respondsToSelector:@selector(mj_replacedKeyFromPropertyName)]){
                replacedName = [self mj_replacedKeyFromPropertyName][aProperty.name];
            }
            if(replacedName.length > 0){
                name = replacedName;
            }
            if([name isEqualToString:valueKeyName]){
                property = aProperty;
                *stop2 = YES;
            }
        }];
        if(property.name.length < 1) return;
        
        if([obj isKindOfClass:[NSNumber class]]){
            if([property.type.typeClass isSubclassOfClass:[NSNumber class]]){
                NSString *str = [NSString sw_fixAccuracyWithString:[obj stringValue]];
                [model setValue:[NSDecimalNumber decimalNumberWithString:str] forKey:property.name];
            }
            else if ([property.type.typeClass isSubclassOfClass:[NSString class]]){
                NSString *str = [NSString sw_fixAccuracyWithString:[obj stringValue]];
                [model setValue:str forKey:property.name];
            }
        }
        else if ([obj isKindOfClass:[NSDictionary class]]){
            id aModel = [model valueForKey:property.name];
            if([aModel isKindOfClass:[NSObject class]] && ![aModel isKindOfClass:[NSDictionary class]]){
                [self __sw_fixModelFloatAccuracyWithModel:aModel dictionary:obj];
            }
        }
        else if ([obj isKindOfClass:[NSArray class]]){
            NSArray *modelArray = [model valueForKey:property.name];
            if(![modelArray isKindOfClass:[NSArray class]]) return;
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull inArrayobj, NSUInteger idx3, BOOL * _Nonnull stop3) {
                if([inArrayobj isKindOfClass:[NSDictionary class]]){
                    id aModel = modelArray.count > idx3? modelArray[idx3]:nil;
                    if([aModel isKindOfClass:[NSObject class]] && ![aModel isKindOfClass:[NSDictionary class]]){
                        [self __sw_fixModelFloatAccuracyWithModel:aModel dictionary:inArrayobj];
                    }
                }
            }];
        }
    }];
}


@end
