//
//  UIDevice+SWExtension.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/6/23.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "UIDevice+SWExtension.h"
#import "sys/sysctl.h"
#import <objc/runtime.h>

@implementation UIDevice (SWExtension)

+ (BOOL)sw_isSpecifiedIOSOrLater:(NSString *)specifiedIOSVersion {
    return [[[UIDevice currentDevice] systemVersion] compare:specifiedIOSVersion options:NSNumericSearch] != NSOrderedAscending;
}

+ (BOOL)sw_isIOS7OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"7.0"];
    });
    return flag;
}

+ (BOOL)sw_isIOS8OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"8.0"];
    });
    return flag;
}


+ (BOOL)sw_isIOS9OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"9.0"];
    });
    return flag;
}


+ (BOOL)sw_isIOS10OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"10.0"];
    });
    return flag;
}

+ (BOOL)sw_isIOS11OrLater {
    static BOOL flag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flag = [self sw_isSpecifiedIOSOrLater:@"11.0"];
    });
    return flag;
}

+ (BOOL)sw_isIPhoneX __deprecated_msg("Use 'sw_isIPhoneXSeries'"){
    return [self sw_isIPhoneXSeries];
}

+ (BOOL)sw_isIPhoneXSeries {
//    static BOOL flag;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        //        CGFloat height = [UIScreen mainScreen].bounds.size.height;
//        //        if((width == 375 && height == 812) || (height == 375 && width == 812)) {//iPhone X,iPhone XS
//        //            flag = YES;
//        //        }else if ((width == 414 && height == 896) || (height == 896 && width == 414)){//iPhone XR,iPhone XS Max
//        //            flag = YES;
//        //        }
//        CGSize size = [UIScreen mainScreen].currentMode.size;
//        if(CGSizeEqualToSize(CGSizeMake(1125, 2436), size) ||//iPhone X
//           CGSizeEqualToSize(CGSizeMake(828, 1792), size) ||//iPhone XR
//           CGSizeEqualToSize(CGSizeMake(1242, 2688), size) //iPhone XS Max
//           ){
//            flag = YES;
//        }
//    });
//    return flag;
    return ![self sw_isNormalScreen];
}

+ (UIEdgeInsets)sw_safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        NSString *const safeAreaInsetsWindow = @"sw_safeAreaInsetsWindow";
        UIWindow *window = objc_getAssociatedObject([UIDevice currentDevice], (__bridge const void * _Nonnull)(safeAreaInsetsWindow));
        if(window == nil){
            window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            objc_setAssociatedObject([UIDevice currentDevice], (__bridge const void * _Nonnull)(safeAreaInsetsWindow), window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        return window.safeAreaInsets;
    } else {
        // Fallback on earlier versions
        return UIEdgeInsetsZero;
    }
}

+ (BOOL)sw_isNormalScreen {
//    return [self sw_deviceModelType] == SWDeviceModelTypeNormal;
    return UIEdgeInsetsEqualToEdgeInsets([self sw_safeAreaInsets], UIEdgeInsetsZero);
}

+ (SWDeviceModelType)sw_deviceModelType __deprecated {
    static SWDeviceModelType deviceType = SWDeviceModelTypeNormal;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //后面是开启放大模式的分辨率
        CGSize size = [UIScreen mainScreen].currentMode.size;
        NSLog(@"---size:%@---nativeScale:%@---scale:%@---",NSStringFromCGSize(size),@([UIScreen mainScreen].nativeScale),@([UIScreen mainScreen].scale));
        [self sw_deviceString];
        if(CGSizeEqualToSize(CGSizeMake(1125, 2436), size)){
            //iPhoneX,XS,11Pro
            deviceType = SWDeviceModelTypeIPhoneX;
        }
        else if (CGSizeEqualToSize(CGSizeMake(828, 1792), size)||CGSizeEqualToSize(CGSizeMake(750, 1624), size)) {
            //XR,11
            deviceType = SWDeviceModelTypeIPhoneXR;
        }
        else if (CGSizeEqualToSize(CGSizeMake(1242, 2688), size)||CGSizeEqualToSize(CGSizeMake(1125, 2436), size)){
            //XSMax,11Pro Max
            deviceType = SWDeviceModelTypeIPhoneXSMax;
        }
        else if (([UIScreen mainScreen].nativeScale == 3&&CGSizeEqualToSize(CGSizeMake(1125, 2436), size))||([UIScreen mainScreen].nativeScale == 3.515625 &&CGSizeEqualToSize(CGSizeMake(960, 2079), size))){
            deviceType = SWDeviceModelTypeIPhone12Mini;
        }
        else if (CGSizeEqualToSize(CGSizeMake(1170, 2532), size)||CGSizeEqualToSize(CGSizeMake(960, 2079), size)){
            //iPhone12 iPhone12Pro
            deviceType = SWDeviceModelTypeIPhone12Pro;
        }
        else if (CGSizeEqualToSize(CGSizeMake(1284, 2778), size)||CGSizeEqualToSize(CGSizeMake(1125, 2436), size)){
            deviceType = SWDeviceModelTypeIPhone12ProMax;
        }
    });
    return deviceType;
}

+ (CGFloat)sw_navigationBarHeight {
//    SWDeviceModelType modelType = [self sw_deviceModelType];
//    if(modelType == SWDeviceModelTypeNormal) return 64;
//    if(modelType <= SWDeviceModelTypeIPhone11ProMax) return 88;
//    if(modelType == SWDeviceModelTypeIPhone12Mini) return 94;
//    if(modelType == SWDeviceModelTypeIPhone12) return 91;
//    if(modelType == SWDeviceModelTypeIPhone12Pro) return 91;
//    if(modelType == SWDeviceModelTypeIPhone12ProMax) return 91;
//    return 88;
    return 44 + [self sw_safeAreaInsets].top;
}

+ (CGFloat)sw_tabBarHeight {
//    SWDeviceModelType modelType = [self sw_deviceModelType];
//    if(modelType == SWDeviceModelTypeNormal) return 49;
//    return 83;
    return 49 + [self sw_safeAreaInsets].bottom;
}

+ (CGFloat)sw_statusBarHeight {
//    SWDeviceModelType modelType = [self sw_deviceModelType];
//    if(modelType == SWDeviceModelTypeNormal) return 20;
//    if(modelType <= SWDeviceModelTypeIPhone11ProMax) return 44;
//    if(modelType == SWDeviceModelTypeIPhone12Mini) return 44;
//    if(modelType == SWDeviceModelTypeIPhone12) return 47;
//    if(modelType == SWDeviceModelTypeIPhone12Pro) return 47;
//    if(modelType == SWDeviceModelTypeIPhone12ProMax) return 47;
//
//    return 44;
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)sw_safeTopInset {
//    SWDeviceModelType modelType = [self sw_deviceModelType];
//    if(modelType == SWDeviceModelTypeNormal) return 0.0;
//    if(modelType == SWDeviceModelTypeIPhoneXR) return 48.0;
//    if(modelType == SWDeviceModelTypeIPhone11) return 48.0;
//    if(modelType == SWDeviceModelTypeIPhone12Mini) return 50;
//    if(modelType == SWDeviceModelTypeIPhone12) return 47;
//    if(modelType == SWDeviceModelTypeIPhone12Pro) return 47;
//    if(modelType == SWDeviceModelTypeIPhone12ProMax) return 47;
//    return 44;
    return [self sw_safeAreaInsets].top;
}

+ (CGFloat)sw_safeBottomInset {
//    SWDeviceModelType modelType = [self sw_deviceModelType];
//    if(modelType == SWDeviceModelTypeNormal) return 0.0;
//    return 34.0;
    return [self sw_safeAreaInsets].bottom;
}

/*
 一.UDID(Unique Device Identifier)
 UDID的全称是Unique Device Identifier，它就是苹果iOS设备的唯一识别码，它由40位16进制数的字母和数字组成（越狱的设备通过某些工具可以改变设备的UDID）。移动网络可利用UDID来识别移动设备，但是，从IOS5.0（2011年8月份）开始，苹果宣布将不再支持用uniqueIdentifier方法获取设备的UDID，iOS5以下是可以用的。苹果从iOS5开始就移除了通过代码访问UDID的权限。从2013年5月1日起，试图访问UIDIDs的程序将不再被审核通过，替代的方案是开发者应该使用“在iOS 6中介绍的Vendor或Advertising标示符”。所以UDID是绝对是不能再使用了.
 //UUID , 已废除
 NSString *udid = [[UIDevice currentDevice] uniqueIdentifier];
 为什么苹果反对开发人员使用UDID？
 iOS 2.0版本以后UIDevice提供一个获取设备唯一标识符的方法uniqueIdentifier，通过该方法我们可以获取设备的序列号，这个也是目前为止唯一可以确认唯一的标示符。 许多开发者把UDID跟用户的真实姓名、密码、住址、其它数据关联起来；网络窥探者会从多个应用收集这些数据，然后顺藤摸瓜得到这个人的许多隐私数据。同时大部分应用确实在频繁传输UDID和私人信息。 为了避免集体诉讼，苹果最终决定在iOS 5 的时候，将这一惯例废除，开发者被引导生成一个唯一的标识符，只能检测应用程序，其他的信息不提供。现在应用试图获取UDID已被禁止且不允许上架。
 
 二.UUID(Universally Unique Identifier)
 UUID是Universally Unique Identifier的缩写，中文意思是通用唯一识别码。它是让分布式系统中的所有元素，都能有唯一的辨识资讯，而不需要透过中央控制端来做辨识资讯的指定。这样，每个人都可以建立不与其它人冲突的 UUID。在此情况下，就不需考虑数据库建立时的名称重复问题。苹果公司建议使用UUID为应用生成唯一标识字符串。
 获得的UUID值系统没有存储, 而且每次调用得到UUID，系统都会返回一个新的唯一标示符。如果你希望存储这个标示符，那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方。
 */
// 获取UUID的方法
+ (NSString *)sw_getUUID {
    CFUUIDRef puuid = CFUUIDCreate(NULL);
    CFStringRef uuidString = CFUUIDCreateString(NULL, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    return result;
}

- (NSString *)sw_deviceString __deprecated {
    static NSString *name;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        name = [[self sw_getDeviceName] copy];
    });
    return name;
}

+ (NSString *)sw_deviceString {
    static NSString *name;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        name = [[[UIDevice currentDevice] sw_getDeviceName] copy];
    });
    return name;
}


#pragma mark - Private
- (NSString *)sw_getDeviceName {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    NSLog(@"platform:%@",platform);
    free(machine);
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS MAX";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE (2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    //iPod
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6";
    if ([platform isEqualToString:@"iPod9,1"])   return @"iPod Touch 7";

    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (32nm)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini 1 (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad mini 1 (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad mini 1 (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (4G)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (4G)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro (9.7 inch)";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro (9.7 inch)";
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro (12.9 inch)";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro (12.9 inch)";
    if ([platform isEqualToString:@"iPad6,11"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad6,12"])  return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,1"])  return @"iPad Pro (12.9-inch) 2nd";
    if ([platform isEqualToString:@"iPad7,2"])  return @"iPad Pro (12.9-inch) 2nd";
    if ([platform isEqualToString:@"iPad7,3"])  return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])  return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,5"])  return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,6"])  return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,11"])  return @"iPad 7";
    if ([platform isEqualToString:@"iPad7,12"])  return @"iPad 7";
    if ([platform isEqualToString:@"iPad8,1"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,2"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,3"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,4"])  return @"iPad Pro (11-inch) ";
    if ([platform isEqualToString:@"iPad8,5"])  return @"iPad Pro (12.9-inch) 3rd";
    if ([platform isEqualToString:@"iPad8,6"])  return @"iPad Pro (12.9-inch) 3rd";
    if ([platform isEqualToString:@"iPad8,7"])  return @"iPad Pro (12.9-inch) 3rd";
    if ([platform isEqualToString:@"iPad8,8"])  return @"iPad Pro (12.9-inch) 3rd";
    if ([platform isEqualToString:@"iPad8,9"])  return @"iPad Pro (11-inch) 2nd";
    if ([platform isEqualToString:@"iPad8,10"])  return @"iPad Pro (11-inch) 2nd";
    if ([platform isEqualToString:@"iPad8,11"])  return @"iPad Pro (12.9-inch) 4th";
    if ([platform isEqualToString:@"iPad8,12"])  return @"iPad Pro (12.9-inch) 4th";
    if ([platform isEqualToString:@"iPad11,1"])  return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,2"])  return @"iPad mini 5";
    if ([platform isEqualToString:@"iPad11,3"])  return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad11,4"])  return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad11,6"])  return @"iPad 8";
    if ([platform isEqualToString:@"iPad11,7"])  return @"iPad 8";
    if ([platform isEqualToString:@"iPad13,1"])  return @"iPad Air 4";
    if ([platform isEqualToString:@"iPad13,2"])  return @"iPad Air 4";
    if ([platform isEqualToString:@"iPad13,4"])  return @"iPad Pro (11-inch) 3rd";
    if ([platform isEqualToString:@"iPad13,5"])  return @"iPad Pro (11-inch) 3rd";
    if ([platform isEqualToString:@"iPad13,6"])  return @"iPad Pro (11-inch) 3rd";
    if ([platform isEqualToString:@"iPad13,7"])  return @"iPad Pro (11-inch) 3rd";
    if ([platform isEqualToString:@"iPad13,8"])  return @"iPad Pro (12.9-inch) 5th";
    if ([platform isEqualToString:@"iPad13,9"])  return @"iPad Pro (12.9-inch) 5th";
    if ([platform isEqualToString:@"iPad13,10"])  return @"iPad Pro (12.9-inch) 5th";
    if ([platform isEqualToString:@"iPad13,11"])  return @"iPad Pro (12.9-inch) 5th";
    
    //Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])   return @"Apple Watch 38mm";
    if ([platform isEqualToString:@"Watch1,2"])   return @"Apple Watch 42mm";
    if ([platform isEqualToString:@"Watch2,3"])   return @"Apple Watch Series 2 38mm";
    if ([platform isEqualToString:@"Watch2,4"])   return @"Apple Watch Series 2 42mm";
    if ([platform isEqualToString:@"Watch2,6"])   return @"Apple Watch Series 1 38mm";
    if ([platform isEqualToString:@"Watch2,7"])   return @"Apple Watch Series 1 42mm";
    
    //Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"])  return @"Apple TV 2";
    if ([platform isEqualToString:@"AppleTV3,1"])  return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])  return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV5,3"])  return @"Apple TV 4";
    
    
    //Simulator
    if ([platform isEqualToString:@"i386"])    return @"iPhone Simulator x86";
    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator x64";
    
    return platform;
}





@end
