//
//  UIViewController+Authorization.h
//  Chat
//
//  Created by 周少文 on 2016/11/1.
//  Copyright © 2016年 周少文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Authorization)

/**
 是否有相机权限
 */
- (BOOL)sw_isHaveCameraAuthorization;

/**
 是否有相册权限
 */
- (BOOL)sw_isHavePhotoLibarayAuthorization;

/**
 是否有麦克风权限
 */
- (BOOL)sw_isHaveMicrophoneAuthorization;

/**
 是否有语音识别权限
 */
- (BOOL)sw_isHaveSpeechRecognizerAuthorization;

/**
 是否有定位权限
 */
- (BOOL)sw_isHaveLocationAuthorization;

@end
