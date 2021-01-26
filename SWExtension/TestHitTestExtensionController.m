//
//  TestHitTestExtensionController.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/25.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "TestHitTestExtensionController.h"
#import <SWExtension.h>
#import <Masonry/Masonry.h>

@interface TestHitTestExtensionController ()
{
    UIButton *_redBtn;
}
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *centerBtn;

@end

@implementation TestHitTestExtensionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.top.mas_equalTo(UIDevice.sw_statusBarHeight);
    }];
    [self.topView sw_addTapGestureRecognizerWithActionBlock:^(UIGestureRecognizer * _Nonnull gestureRecognizer) {
        NSLog(@"topViewTaped");
    }];
    
    //默认一个view上的另一个subview在超过superview的区域位置是无法感应到手势的
    //通过下面的方式可以让超过的部分也能感应到手势
    __weak typeof(self) weakSelf = self;
    self.centerBtn.sw_eventThroughView = ^UIView * _Nonnull(CGPoint point, UIEvent * _Nonnull event, UIView * _Nonnull originalTargetView) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        return strongSelf->_redBtn;
    };
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //默认情况下一个视图在另一个视图上层的时候 点击上层的时候是无法将事件传递给下层视图的
    //通过下面的方式可以做到点击透明的导航 可以让手势事件传递给后面的view

    //方式1
//    self.navigationController.navigationBar.sw_hitTestTargetView = ^UIView * _Nonnull(CGPoint point, UIEvent * _Nonnull event, UIView * _Nonnull originalTargetView) {
//        NSLog(@"originalTargetView:%@",originalTargetView);
//        if([originalTargetView isKindOfClass:NSClassFromString(@"_UIButtonBarButton")]){
//            return originalTargetView;
//        }
//        CGPoint point2 = [self.navigationController.navigationBar convertPoint:point toView:self.topView];
//        return [self.topView hitTest:point2 withEvent:event];
//    };
    
    //方式2
    __weak typeof(self) weakSelf = self;
    self.navigationController.navigationBar.sw_eventThroughView = ^UIView * _Nonnull(CGPoint point, UIEvent * _Nonnull event, UIView * _Nonnull originalTargetView) {
        NSLog(@"originalTargetView:%@",originalTargetView);
        if([originalTargetView isKindOfClass:NSClassFromString(@"_UIButtonBarButton")]){
            //点击了UIBarButtonItem
            return nil;
        }
        return weakSelf.topView;
    };
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.sw_hitTestTargetView = nil;
    self.navigationController.navigationBar.sw_eventThroughView = nil;
}

- (IBAction)btnAction:(UIButton *)sender {
    NSLog(@"btnClick");
}
- (IBAction)centerBtnAction:(UIButton *)sender {
    NSLog(@"centerBtnAction");
    sender.clipsToBounds = NO;
    if(_redBtn) return;
    UIButton *redBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _redBtn = redBtn;
    [redBtn setBackgroundColor:[UIColor redColor]];
    redBtn.frame = CGRectMake(CGRectGetWidth(sender.frame) - 10, 0, 100, 50);
    [sender addSubview:redBtn];
    [redBtn addTarget:self action:@selector(redBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)redBtnClick {
    NSLog(@"redBtnClick");
}

- (void)dealloc
{
    NSLog(@"%@--dealloc",[self class]);
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
