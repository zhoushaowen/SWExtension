//
//  NSURL+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2021/9/15.
//  Copyright © 2021 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (SWExtension)
/// 通过string创建url,如果字符串路径包含中文等特殊字符内部会自动进行编码
/// @param str 字符串路径
+ (NSURL *_Nullable)sw_URLWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
