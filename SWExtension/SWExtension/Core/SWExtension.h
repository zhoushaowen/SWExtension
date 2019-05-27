//
//  SWExtension.h
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef _SWEXTENSION_
    #define _SWEXTENSION_
//Foundation
#import "NSString+Date.h"
#import "NSString+Hash.h"
#import "NSString+Emoji.h"
#import "NSString+Valid.h"
#import "NSString+SWExtension.h"
#import "NSTimer+SWUnRetainTimer.h"
#import "NSDate+SWExtension.h"

//UIKit
#import "UIImage+SWExtension.h"
#import "UIView+SWAutoLayout.h"
#import "UIView+ShakeAnimation.h"
#import "UIView+HUD.h"
#import "UIView+SWExtension.h"
#import "UILabel+Animation.h"
#import "UIView+ExpandResponse.h"
#import "UIImageView+SWExtension.h"
#import "UIColor+Hex.h"
#import "UIScrollView+FitIOS11.h"
#import "UITableView+FitIOS11.h"
#import "UITableView+SWExtension.h"
#import "UICollectionView+SWExtension.h"
#import "UIButton+SWExtension.h"
#import "UIViewController+SWImagePicker.h"
#import "UIViewController+SWAlertController.h"
#import "UIDevice+SWExtension.h"
#import "UIApplication+SWExtension.h"
#import "UIFont+SWExtension.h"

#ifdef __cplusplus
#define SWKIT_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define SWKIT_EXTERN	        extern __attribute__((visibility ("default")))
#endif

#endif


