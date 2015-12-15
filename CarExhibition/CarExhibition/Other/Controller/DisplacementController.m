//
//  DisplacementController.m
//  询车问价
//
//  Created by fandi on 15/12/10.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DisplacementController.h"
#import "DisViewController.h"

@interface DisplacementController ()

@end

@implementation DisplacementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return _disArray.count - 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *string = [NSString stringWithFormat:@"%@L",_disArray[indexPath.section]];
   cell.textLabel.text = string;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // DisTableViewController *disTVC = [[DisTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    DisViewController *disViewController = [[DisViewController alloc] init];
    
    NSString *string = [NSString stringWithFormat:@"%@&displacement=%@",_url,_disArray[indexPath.section]];
    
    // disTVC.url = string;
    disViewController.url = string;
    
    // disTVC.navigationItem.title = @"选择车型";
    disViewController.navigationItem.title = @"选择车型";
    
    // [self.navigationController pushViewController:disTVC animated:YES];
    [self.navigationController pushViewController:disViewController animated:YES];
    
}








@end
