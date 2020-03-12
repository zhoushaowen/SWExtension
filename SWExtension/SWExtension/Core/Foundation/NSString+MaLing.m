//
//  NSString+MaLing.m
//  CloudPharmacy
//
//  Created by zhoushaowen on 2019/10/30.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "NSString+MaLing.h"


@implementation NSString (MaLing)

- (NSString *)maLing {
    if(self.length < 1) return self;
    NSMutableArray *array = [[self componentsSeparatedByString:@"."] mutableCopy];
    NSString *lastStr = array.lastObject;
    if(array.count > 1){
        if(lastStr.length > 0){
            if([lastStr hasSuffix:@"0"]){
                lastStr = [lastStr substringToIndex:lastStr.length - 1];
                [array removeLastObject];
                if(lastStr.length > 0){
                    NSString *str = [NSString stringWithFormat:@"%@.%@",[array componentsJoinedByString:@"."],lastStr];
                    return [str maLing];
                }
            }
        }else{
            [array removeLastObject];
        }
        return [array componentsJoinedByString:@"."];
    }
    return self;
}


@end
