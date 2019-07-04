//
//  NSArray+SWSafe.h
//  BSPCN
//
//  Created by zhoushaowen on 2019/4/16.
//  Copyright © 2019 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SWSafe)

- (id)sw_safe_objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
