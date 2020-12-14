//
//  AppDelegate.m
//  SWExtension
//
//  Created by zhoushaowen on 2017/4/10.
//  Copyright © 2017年 yidu. All rights reserved.
//

#import "AppDelegate.h"
#import <SWExtension.h>
#import "ImagePickerController.h"
#import <MJExtension.h>
#import <YYModel.h>

@interface TestObj : NSObject

@property (nonatomic,copy) NSString *a;
@property (nonatomic,strong) NSNumber *b;
@property (nonatomic,strong) NSNumber *c;
@property (nonatomic,strong) NSNumber *d;
//@property (nonatomic) float b;
//@property (nonatomic) float c;
//@property (nonatomic) float d;

@end

@implementation TestObj

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [UIDevice sw_isIPhoneXSeries];
//    NSString *str = @"123";
//    NSString *sub = [str substringFromIndex:4];
//    NSString *sub = [str sw_safeSubstringFromIndex:4];
//    NSString *sub = [str substringToIndex:4];
//    NSString *sub = [str sw_safeSubstringToIndex:4];
//    NSString *sub = [str substringWithRange:NSMakeRange(3, 1)];
//    NSString *sub = [str substringWithRange:NSMakeRange(0, 4)];
//    NSString *sub = [str substringWithRange:NSMakeRange(NSNotFound, 0)];
//    NSString *sub = [str sw_safeSubstringWithRange:NSMakeRange(3, 1)];
//    NSString *sub = [str sw_safeSubstringWithRange:NSMakeRange(0, 4)];
//    NSString *sub = [str sw_safeSubstringWithRange:NSMakeRange(NSNotFound, 0)];
    SWUserDefaultsSetObj(@"a", @"hahaha");
    NSLog(@"%@",SWUserDefaultsGetObj(@"a"));
    SWIsIPhoneXSeries;
    SWSafeTopInset;
    SWSafeBottomInset;
    SWNavigationBarHeight;
    SWScreenWidth;
    SWScreenHeight;
    NSLog(@"%d",[UIDevice sw_deviceModelType]);
    [self.window sw_setRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    
//    self.window.rootViewController = [ImagePickerController new];
    
    NSString *jsonStr = @"{\"a\":\"71.40\", \"b\":8.37, \"c\":80.40, \"d\":188.40}";
    NSLog(@"json:%@", jsonStr);
    NSData *jsonData_ = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonParsingError_ = nil;
    NSDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData_ options:0 error:&jsonParsingError_]];
    NSLog(@"dic:%@", dic);
//    TestObj *obj = [TestObj mj_objectWithKeyValues:jsonStr];
//    
//    TestObj *obj2 = [TestObj sw_modelWithKeyValues:jsonStr];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
