//
//  NSURL+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/9/15.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "NSURL+SWExtension.h"
#import "NSString+SWExtension.h"

@implementation NSURL (SWExtension)

+ (NSURL *)sw_URLWithString:(NSString *)str {
    if(str == nil) return nil;
    NSURL *url = [NSURL URLWithString:str];
    //如果str不合规,url可能为空
    if(url == nil){
//        url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        url = [NSURL URLWithString:[str sw_stringByAddingPercentEncoding]];
    }
    
    return url;
}

@end
