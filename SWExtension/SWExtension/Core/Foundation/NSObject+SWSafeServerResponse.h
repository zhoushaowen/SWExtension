//
//  NSObject+SWSafeServerResponse.h
//  BSPCN
//
//  Created by zhoushaowen on 2019/4/16.
//  Copyright © 2019 Vincent. All rights reserved.
// 避免服务器返回的数据不是我们约定好的类型(NSArray或者NSDictionary)而导致的crash

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SWSafeServerResponse)


@end

NS_ASSUME_NONNULL_END
