//
//  NSString+MaLing.h
//  CloudPharmacy
//
//  Created by zhoushaowen on 2019/10/30.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MaLing)

/// 抹掉小数字符串后面的零
- (NSString *)maLing;

@end

NS_ASSUME_NONNULL_END
