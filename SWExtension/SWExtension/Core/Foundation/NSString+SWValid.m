//
//  NSString+SWValid.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/25.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "NSString+SWValid.h"
#import "NSString+SWDate.h"
#import "NSDate+SWExtension.h"

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
    //    if([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1) return NO;
    //    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    //    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //    BOOL valid = [identityCardPredicate evaluateWithObject:self];
    //    if(!valid) return valid;
    //    //验证出身月份和生日日期是否合法
    //    if(self.length == 18){
    //        NSInteger month = [[self substringWithRange:NSMakeRange(10, 2)] integerValue];
    //        NSInteger day = [[self substringWithRange:NSMakeRange(12, 2)] integerValue];
    //        if(month < 13 && month > 0 && day < 32 && day > 0) return YES;
    //        return NO;
    //    }else if (self.length == 15){
    //        NSInteger month = [[self substringWithRange:NSMakeRange(8, 2)] integerValue];
    //        NSInteger day = [[self substringWithRange:NSMakeRange(10, 2)] integerValue];
    //        if(month < 13 && month > 0 && day < 32 && day > 0) return YES;
    //        return NO;
    //    }
    //    return NO;
    //判断位数
    if ([self length] != 15 && [self length] != 18) {
        return NO;
    }
    
    long lSumQT =0;
    //加权因子
    int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    NSString *carid = [self copy];
    
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    
    if ([self length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![NSString sw_checkAreaCode:sProvince]) {
        return NO;
    }
    //判断年月日是否有效
    //年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    
    
    //月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    //日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    //验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
    
}

+ (BOOL)sw_checkAreaCode:(NSString *)code
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
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

- (NSString *)sw_parseAgeFromIdentityCard {
    NSString *birthdayStr = [self sw_parseBirthdayFromIdentityCard];
    if(birthdayStr == nil) return nil;
    NSDate *birthday = [NSDate sw_createDateWithDateString:birthdayStr dateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:birthday toDate:[NSDate date] options:0];
    return @(components.year).stringValue;
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
