//
//  SWExtensionConst.h
//  MBProgressHUD
//
//  Created by zhoushaowen on 2019/12/3.
//

#ifndef _SWExtensionConst_
#define _SWExtensionConst_

#import <Foundation/Foundation.h>

#define SWSingletonInterface \
+ (instancetype)sharedInstance;\
+ (void)destroyInstance;

#define SWSingletonImplementation \
static id instance = nil;\
static dispatch_once_t onceToken1;\
static dispatch_once_t onceToken2;\
+ (instancetype)sharedInstance {\
    dispatch_once(&onceToken1, ^{\
        if(instance == nil){\
            instance = [[self alloc] init];\
        }\
    });\
    return instance;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
    dispatch_once(&onceToken2, ^{\
        if(instance == nil){\
            instance = [super allocWithZone:zone];\
        }\
    });\
    return instance;\
}\
+ (void)destroyInstance {\
    onceToken1 = 0;/*只有置成0,GCD才会认为它从未执行过.它默认为0,这样才能保证下次再次调用shareInstance的时候,再次创建对象.*/\
    onceToken2 = 0;\
    instance = nil;\
}\
- (void)dealloc\
{\
    NSLog(@"----%@---%s",self,__func__);\
}



#define SWCreateColorWithHex(hex) [UIColor colorWithHexString:@#hex]
#define SWCreateImageWithHex(hex) [UIImage sw_createImageWithColor:[UIColor colorWithHexString:@#hex]]

#define SWScreenWidth [UIScreen mainScreen].bounds.size.width
#define SWScreenHeight [UIScreen mainScreen].bounds.size.height

#define SWUserDefaultsSetObj(key,obj) \
[[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define SWUserDefaultsGetObj(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define SWSafeTopInset UIDevice.sw_safeTopInset
#define SWSafeBottomInset UIDevice.sw_safeBottomInset
#define SWNavigationBarHeight UIDevice.sw_navigationBarHeight
#define SWStatusBarHeight UIDevice.sw_statusBarHeight
#define SWTabBarHeight UIDevice.sw_tabBarHeight
#define SWIsIPhoneXSeries UIDevice.sw_isIPhoneXSeries
#define SWIsNormalScreen UIDevice.sw_isNormalScreen
#define SWSafeAreaInsets UIDevice.sw_safeAreaInsets
#define SWImageWithName(name) [UIImage imageNamed:@#name]


#endif
