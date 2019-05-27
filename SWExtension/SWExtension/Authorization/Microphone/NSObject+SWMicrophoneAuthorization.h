//
//  NSObject+SWMicrophoneAuthorization.h
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SWMicrophoneAuthorization)

+ (void)requestMicrophoneAuthorizationWithCompletion:(void(^ _Nullable)(BOOL isAuthorized))completedBlock alertViewController:(UIViewController *_Nullable)alertViewController;

@end

NS_ASSUME_NONNULL_END
