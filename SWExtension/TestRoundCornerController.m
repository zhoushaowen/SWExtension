//
//  TestRoundCornerController.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/14.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "TestRoundCornerController.h"
#import <SWExtension.h>

@interface TestRoundCornerController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation TestRoundCornerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SWNavigationBarHeight, SWScreenWidth, SWScreenHeight - SWNavigationBarHeight - SWTabBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView sw_setRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(50, 50)];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor purpleColor];
        [cell sw_setRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(30, 30)];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
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
