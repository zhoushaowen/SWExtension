//
//  UITextField+SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2020/12/11.
//  Copyright © 2020 yidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SWExtension)

@property (nonatomic,strong) void(^sw_textDidEndEditingBlock)(UITextField *tf);
@property (nonatomic,strong) void(^sw_textDidChangeBlock)(UITextField *tf);
@property (nonatomic,strong) void(^sw_textDidBeginEditingBlock)(UITextField *tf);

@end

NS_ASSUME_NONNULL_END
