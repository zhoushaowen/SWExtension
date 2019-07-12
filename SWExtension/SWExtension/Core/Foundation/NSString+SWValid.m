//
//  NSString+SWValid.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/25.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "NSString+SWValid.h"

@implementation NSString (SWValid)

//判断手机号码格式是否正确
//- (BOOL)isValidPhoneNumber
//{
//    if(![self isKindOfClass:[NSString class]]) return NO;
//    NSString *number = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if (number.length != 11)
//    {
//        return NO;
//    }else{
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:number];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:number];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:number];
//        
//        if (isMatch1 || isMatch2 || isMatch3) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }
//}

- (BOOL)sw_isEmailString {
    if([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1) return NO;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)sw_isValidateIdentityCard {
    if([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1) return NO;
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL valid = [identityCardPredicate evaluateWithObject:self];
    if(!valid) return valid;
    //验证出身月份和生日日期是否合法
    if(self.length == 18){
        NSInteger month = [[self substringWithRange:NSMakeRange(10, 2)] integerValue];
        NSInteger day = [[self substringWithRange:NSMakeRange(12, 2)] integerValue];
        if(month < 13 && month > 0 && day < 32 && day > 0) return YES;
        return NO;
    }else if (self.length == 15){
        NSInteger month = [[self substringWithRange:NSMakeRange(8, 2)] integerValue];
        NSInteger day = [[self substringWithRange:NSMakeRange(10, 2)] integerValue];
        if(month < 13 && month > 0 && day < 32 && day > 0) return YES;
        return NO;
    }
    return NO;
}

- (NSString *)sw_parseBirthdayFromIdentityCard {
    if(![self sw_isValidateIdentityCard]) return nil;
    //解析身份证中的生日
    if(self.length == 18){
        //18位身份证
        return [[[[[self substringWithRange:NSMakeRange(6, 4)] stringByAppendingString:@"-"] stringByAppendingString:[self substringWithRange:NSMakeRange(10, 2)]] stringByAppendingString:@"-"] stringByAppendingString:[self substringWithRange:NSMakeRange(12, 2)]];
    }else if (self.length == 15){
        //15位身份证
        return [[[[[NSString stringWithFormat:@"19%@",[self substringWithRange:NSMakeRange(6, 2)]] stringByAppendingString:@"-"] stringByAppendingString:[self substringWithRange:NSMakeRange(8, 2)]] stringByAppendingString:@"-"] stringByAppendingString:[self substringWithRange:NSMakeRange(10, 2)]];
    }
    return nil;
}

- (NSString *)sw_parseSexStringFromIdentityCard {
    if(![self sw_isValidateIdentityCard]) return nil;
    if(self.length == 18){
        //18位身份证
        NSInteger sexNum = [[self substringWithRange:NSMakeRange(16, 1)] integerValue];
        if(sexNum%2 == 0){
            //女
            return @"女";
        }else{
            //男
            return @"男";
        }
    }else if (self.length == 15){
        //15位身份证
        NSInteger sexNum = [[self substringWithRange:NSMakeRange(14, 1)] integerValue];
        if(sexNum%2 == 0){
            //女
            return @"女";
        }else{
            //男
            return @"男";
        }
    }
    return nil;
}

- (NSString *)sw_parseSexCodeFromIdentityCard {
    if(![self sw_isValidateIdentityCard]) return nil;
    if(self.length == 18){
        //18位身份证
        NSInteger sexNum = [[self substringWithRange:NSMakeRange(16, 1)] integerValue];
        if(sexNum%2 == 0){
            //女
            return @"2";
        }else{
            //男
            return @"1";
        }
    }else if (self.length == 15){
        //15位身份证
        NSInteger sexNum = [[self substringWithRange:NSMakeRange(14, 1)] integerValue];
        if(sexNum%2 == 0){
            //女
            return @"2";
        }else{
            //男
            return @"1";
        }
    }
    return nil;
}

- (BOOL)isEmailString __deprecated {
    return [self sw_isEmailString];
}

- (BOOL)isValidateIdentityCard __deprecated {
    return [self sw_isValidateIdentityCard];
}















@end
