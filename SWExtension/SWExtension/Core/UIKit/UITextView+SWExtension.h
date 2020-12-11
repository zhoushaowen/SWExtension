//
//  UITextView+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (SWExtension)
@property (nonatomic,strong) void(^sw_textDidEndEditingBlock)(UITextView *tv);
@property (nonatomic,strong) void(^sw_textDidChangeBlock)(UITextView *tv);
@property (nonatomic,strong) void(^sw_textDidBeginEditingBlock)(UITextView *tv);

@end

NS_ASSUME_NONNULL_END
