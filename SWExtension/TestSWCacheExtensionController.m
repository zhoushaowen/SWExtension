//
//  TestSWCacheExtensionController.m
//  SWExtension
//
//  Created by zhoushaowen on 2021/1/12.
//  Copyright © 2021 yidu. All rights reserved.
//

#import "TestSWCacheExtensionController.h"
#import <SWExtension.h>

@interface TempTableViewCell : UITableViewCell

@end

@implementation TempTableViewCell

@end


@interface TestSWCacheExtensionController ()

@end

@implementation TestSWCacheExtensionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView sw_registerCellWithClass:[UITableViewCell class]];
    [self.tableView sw_registerCellWithClass:[TempTableViewCell class]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row %2 == 0){
        TempTableViewCell *cell = [tableView sw_dequeueReusableCellWithClass:[TempTableViewCell class]];
        return cell;
    }
    
    UITableViewCell *cell = [tableView sw_dequeueReusableCellWithClass:[UITableViewCell class]];
    
    // Configure the cell...
    cell.textLabel.text = @(indexPath.row).stringValue;
    [tableView sw_setRowHeight:UITableViewAutomaticDimension forIndexPath:indexPath];

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = [tableView sw_rowHeightForIndexPath:indexPath];
    if(rowHeight < 0){
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        if([cell isKindOfClass:[TempTableViewCell class]]){
            rowHeight = 0;
            [tableView sw_setRowHeight:rowHeight forIndexPath:indexPath];
        }else{
            [tableView sw_setRowHeight:UITableViewAutomaticDimension forIndexPath:indexPath];
        }
    }
    NSLog(@"%@",rowHeight == UITableViewAutomaticDimension?@"yes":@"no");
    return rowHeight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
