//
//  MainTableViewController.m
//  SWExtension
//
//  Created by zhoushaowen on 2018/6/4.
//  Copyright © 2018年 yidu. All rights reserved.
//

#import "MainTableViewController.h"
#import <SWExtension.h>

@interface MainTableViewController ()
{
    NSArray *_dataSource;
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _dataSource = @[
                    @"ImagePickerController",
                    @"ArrayAndDictionaryChineseOutputController",
                    @"PhotoLibraryAuthorizationViewController",
                    @"SpeechRecognizerAuthorizationViewController",
                    @"MicrophoneAuthorizationViewController",
                    @"CameraAuthorizationViewController",
                    @"SingletonTestViewController",
                    @"EmojiTestViewController",
                    @"BorderStyleTestViewController",
                    @"SWSafeServerResponseTestVC",
                    @"TestVCExtensionController"
                    ];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = (UIViewController *)[[NSClassFromString(_dataSource[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
