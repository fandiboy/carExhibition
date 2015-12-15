//
//  MoreMarketTableViewController.m
//  询车问价
//
//  Created by 贺聪 on 15/12/10.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "MoreMarketTableViewController.h"
#import "MarketTableViewCell.h"
#import "DepreciateDetailController.h"

@interface MoreMarketTableViewController ()

@end

@implementation MoreMarketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"行情";
    [self.tableView registerNib:[UINib nibWithNibName:@"MarketTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"chexun_backarrow_black"] style:UIBarButtonItemStylePlain target:self action:@selector(pop:)];
    
   }

-(void)pop:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.market = _array[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Market *model = self.array[indexPath.row];
    DepreciateDetailController *depreciateDetailVC = [[DepreciateDetailController alloc] init];
    depreciateDetailVC.url = model.url;
    depreciateDetailVC.title = model.title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:depreciateDetailVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
