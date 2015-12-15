//
//  MarketTableViewController.m
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "MarketTableViewController.h"
#import "MarketTableViewCell.h"
#import "MoreTableViewCell.h"
#import "MoreMarketTableViewController.h"
#import "LNNavigationController.h"
#import "DepreciateDetailController.h"

@interface MarketTableViewController ()
@property(nonatomic,retain)NSMutableArray * array;
@property(nonatomic,retain)MBProgressHUD * HUD;
@end

@implementation MarketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.separatorStyle = NO; //隐藏tableView的线
    [self.tableView registerNib:[UINib nibWithNibName:@"MarketTableViewCell" bundle:nil] forCellReuseIdentifier:@"marketCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];
    self.tableView.scrollEnabled =NO; //设置tableview 不能滚动
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //实际返回文本是HTML格式的,但是数据是json格式的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:self.marketUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"成功了");
        NSArray * array = [NSArray arrayWithArray:responseObject];
        self.array = [NSMutableArray array];
        
        for (NSDictionary * dic in array) {
            self.market = [Market new];
            [_market setValuesForKeysWithDictionary:dic];
            [_array addObject:_market];
        }
        
        if (_array.count == 0) {
            self.tableView.separatorStyle = NO; //隐藏tableView的线
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.tableView.frame.size.height)];
            view.backgroundColor = [UIColor whiteColor];
            
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2 - 20, view.frame.size.height/2 - 40, 40, 40)];
            imgView.image = [UIImage imageNamed:@"chexun_tanhaoicon"];
            [view addSubview:imgView];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.frame.origin.y + imgView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 30)];
            label.text = @"暂时没有行情数据";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:13];
            [view addSubview:label];
            [self.tableView addSubview:view];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败了,%@",error);
    }];
    

    
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 3) {
        MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"marketCell" forIndexPath:indexPath];
        if (_array.count > indexPath.row) {
            self.market = _array[indexPath.row];
            cell.market = _market;
        }
        return cell;
    }else{
        MoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
        cell.lab4More.text = @"查看更多的行情";
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 3) {
        return 49;
    }else{
        return 30;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 3) {
        Market *model = self.array[indexPath.row];
        DepreciateDetailController *depreciateDetailVC = [[DepreciateDetailController alloc] init];
        depreciateDetailVC.url = model.url;
        depreciateDetailVC.title = model.title;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:depreciateDetailVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        MoreMarketTableViewController * moreMarketVC = [[MoreMarketTableViewController alloc]initWithStyle:UITableViewStylePlain];
        moreMarketVC.array = _array;
        LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:moreMarketVC];
        [self presentViewController:nav animated:YES completion:nil];
        
    }
}
@end
