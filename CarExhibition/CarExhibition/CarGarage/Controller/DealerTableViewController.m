//
//  DealerTableViewController.m
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DealerTableViewController.h"
#import "DealerTableViewCell.h"
#import "Dealer.h"
#import <CoreLocation/CoreLocation.h>//定位框架
#import "MoreTableViewCell.h"
#import "MoreDealerTableViewController.h"
#import "LNNavigationController.h"
#import "DealerDetailTableViewController.h"
@interface DealerTableViewController ()<CLLocationManagerDelegate>//定位协议
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)CLLocationManager * locationManager;//定位对象
@property(nonatomic,retain)MBProgressHUD * HUD;
@end

@implementation DealerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DealerTableViewCell" bundle:nil] forCellReuseIdentifier:@"dealerCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"MoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"moreCell"];
    
    self.tableView.scrollEnabled = NO; //设置tableview 不能滚动

    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    //设置定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    //设置定位的条件距离,正常情况下只有位置超过了这个值,才会执行毁掉方法
    _locationManager.distanceFilter = 100.0;
    //位置管理向用户请求授权(随时都可以用你的位置信息)
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //实际返回文本是HTML格式的,但是数据是json格式的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:self.dealerUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"成功了");
        
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray * array = dic[@"dealerList"];
        self.array = [NSMutableArray array];
        for (NSDictionary * dic in array) {
            self.dealer = [Dealer new];
            [_dealer setValuesForKeysWithDictionary:dic];
            [_array addObject:_dealer];
        }
        
        if (_array.count == 0) {
            self.tableView.separatorStyle = NO; //隐藏tableView的线
            self.tableView.separatorStyle = NO; //隐藏tableView的线
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.tableView.frame.size.height)];
            view.backgroundColor = [UIColor whiteColor];
            
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2 - 20, view.frame.size.height/2 - 40, 40, 40)];
            imgView.image = [UIImage imageNamed:@"chexun_tanhaoicon"];
            [view addSubview:imgView];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.frame.origin.y + imgView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 30)];
            label.text = @"暂时没有经销商数据";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:13];
            [view addSubview:label];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView addSubview:view];
            });
        
        }
        
        [self.tableView reloadData];
        
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        return 73.5;
    }else{
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 2 ) {
        DealerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dealerCell" forIndexPath:indexPath];
        if (_array.count > indexPath.row) {
            self.dealer = _array[indexPath.row];
            cell.dealer = _dealer;
        }
        return cell;
    }else{
        MoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
        cell.lab4More.text = @"查看更多的经销商";
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        DealerDetailTableViewController * dealerDetailVC = [[DealerDetailTableViewController alloc]initWithStyle:UITableViewStylePlain];
        dealerDetailVC.dealer = _array[indexPath.row];
        LNNavigationController * nc = [[LNNavigationController alloc]initWithRootViewController:dealerDetailVC];
        [self presentViewController:nc animated:YES completion:nil];
    }else{
        MoreDealerTableViewController * moreDealerVC = [[MoreDealerTableViewController alloc]initWithStyle:UITableViewStylePlain];
        LNNavigationController * nc = [[LNNavigationController alloc]initWithRootViewController:moreDealerVC];
        moreDealerVC.array = _array;
        [self presentViewController:nc animated:YES completion:nil];
    }
}


@end
