//
//  NearbyController.m
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "NearbyController.h"
#import <CoreLocation/CoreLocation.h>
#import "Nearby4S.h"
#import "NearbyTableViewCell.h"

@interface NearbyController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation NearbyController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)dataManager{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 创建URL
        NSURL *url = [NSURL URLWithString:self.url];
        // 创建请求对象
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        // 建立会话
        NSURLSession *sesson = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSArray *carModelListArray = dic[@"dealerList"];
                
                
                for (NSDictionary *dict in carModelListArray) {
                    
                    Nearby4S *nearby = [Nearby4S new];
                    [nearby setValuesForKeysWithDictionary:dict];
                    
                    [self.dataArray addObject:nearby];
                    
                }
                
                
                // 返回主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%ld",_dataArray.count);
                    [self.tableView reloadData];
                });
                
            }
            
            
            
        }];
        // 使用resume方法启动任务
        [task resume];
        
    });
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    self.locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    
    // 设置定位精确度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // 设置定位的条件距离，正常情况下只有位置超过了这个值才会执行回调方法
    _locationManager.distanceFilter = 100.0f; // 100M
    
    
    
    // 位置管理向用户请求授权(随时都可以用你的位置信息)
    [_locationManager requestAlwaysAuthorization];
    
    [_locationManager requestWhenInUseAuthorization];
    
    [_locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- CLLocationManagerDelegate
// 当位置管理器监控到位置变化后触发的回调事件
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // 获取定位后的最后一个位置
    CLLocation * location = locations.lastObject;
    NSLog(@"%f--%f",location.coordinate.latitude,location.coordinate.longitude);
    
    
    self.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    
    
    self.url = [NSString stringWithFormat:@"http://dealer.chexun.com/api/GetDealersInfo3.ashx?sortType=2&&longitude=%@&latitude=%@&pageIndex=1&pageSize=10&cityId=1&brandID=0&RegionalID=0",_longitude,_latitude];
    
    
    [self dataManager];
    
    // 结束定位
    // [manager stopUpdatingLocation];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    Nearby4S *nearby = [Nearby4S new];
    nearby = _dataArray[indexPath.row];
    
    
    cell.label4Address.text = [nearby.companyAddress stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    cell.nearby = nearby;
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
    
}

@end
