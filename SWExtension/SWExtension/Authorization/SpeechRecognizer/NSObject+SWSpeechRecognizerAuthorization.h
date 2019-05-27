//
//  NSObject+SWSpeechRecognizerAuthorization.h
//  SWExtension
//
//  Created by zhoushaowen on 2019/5/24.
//  Copyright © 2019 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SWSpeechRecognizerAuthorization)

+ (void)requestSpeechRecognizerAuthorizationWithCompletion:(void(^ _Nullable)(BOOL isAuthorized))completedBlock alertViewController:(UIViewController *_Nullable)alertViewController NS_AVAILABLE_IOS(10.0);

@end

NS_ASSUME_NONNULL_END
