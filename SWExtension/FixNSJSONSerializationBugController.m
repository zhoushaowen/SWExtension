//
//  FixNSJSONSerializationBugController.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/28.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "FixNSJSONSerializationBugController.h"
#import <MJExtension.h>
#import <SWExtension.h>

@interface TestObj : NSObject

@property (nonatomic,copy) NSString *a;
@property (nonatomic,strong) NSDecimalNumber *bb;
@property (nonatomic,copy) NSString *c;
@property (nonatomic,strong) NSNumber *d;
@property (nonatomic,strong) TestObj *obj;
@property (nonatomic,copy) NSArray<TestObj *> *objs;
//@property (nonatomic) float b;
//@property (nonatomic) float c;
//@property (nonatomic) float d;

@end

@implementation TestObj

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [TestObj mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//            return @{
//                @"bb":@"b"
//            };
//        }];
//    }
//    return self;
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"bb":@"b"
    };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"objs":[TestObj class]
    };
}


MJExtensionLogAllProperties

@end

@interface FixNSJSONSerializationBugController ()

@end

@implementation FixNSJSONSerializationBugController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *jsonStr = @"{\"a\":\"71.40\", \"b\":8.37, \"c\":80.40, \"d\":188.40,\"obj\":{\"a\":\"71.40\", \"b\":8.37, \"c\":80.40, \"d\":188.40},\"objs\":[{\"a\":\"71.40\", \"b\":8.37, \"c\":80.40, \"d\":188.40,\"objs\":[{\"a\":\"71.40\", \"b\":8.37, \"c\":80.40, \"d\":188.40}]}]}";
    NSLog(@"json:%@", jsonStr);
    NSData *jsonData_ = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonParsingError_ = nil;
    NSDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData_ options:0 error:&jsonParsingError_]];
    NSLog(@"dic:%@", dic);
//    NSLog(@"b:%@",[NSString stringWithFormat:@"%f",[dic[@"b"] doubleValue]]);

    TestObj *obj = [TestObj mj_objectWithKeyValues:jsonStr];
    NSLog(@"obj:%@",obj);
    TestObj *obj2 = [TestObj sw_modelWithKeyValues:jsonStr];
    NSLog(@"obj2:%@",obj2);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
