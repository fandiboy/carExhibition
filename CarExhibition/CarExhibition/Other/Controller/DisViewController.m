//
//  DisViewController.m
//  询车问价
//
//  Created by fandi on 15/12/10.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DisViewController.h"
#import "DisplacementCar.h"
#import "DisTableViewCell.h"
#import "CompareViewController.h"


@interface DisViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation DisViewController


- (NSMutableArray *)dataArray{
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
                NSArray *carModelListArray = dic[@"carModelList"];
                
                
                for (NSDictionary *dict in carModelListArray) {
                    
                    DisplacementCar *displacementCar = [DisplacementCar new];
                    [displacementCar setValuesForKeysWithDictionary:dict];
                    
                    [self.dataArray addObject:displacementCar];
                    
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [self dataManager];
    
    // 注册
    [_tableView registerNib:[UINib nibWithNibName:@"DisTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    
    // 添加底部button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50);
    [btn setBackgroundColor:[UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000]];
    [btn setTitle:@"已选择0款车型，去对比" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(compareClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
   
}


- (void)compareClick:(UIButton *)sender{
    
    NSMutableArray *array = [NSMutableArray array];
    for (DisTableViewCell *cell in self.tableView.visibleCells) {
        if (cell.switch4Choose.isOn) {
            [array addObject:cell];
        }
    }
    CompareViewController *compareVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 5];
    
   
    compareVC.url = self.url;
    compareVC.disArray = array;
    // 根据控制器数组 pop到指定的viewController
    // [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    [self.navigationController popToViewController:compareVC animated:YES];
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
    DisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DisplacementCar *disCar = [DisplacementCar new];
    disCar = _dataArray[indexPath.row];
    cell.displacementCar = disCar;
    
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    cell.switch4Choose.on =  [userDefaults boolForKey:cell.displacementCar.name];
    // NSLog(@"樊迪%d", cell.switch4Choose.isOn);
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}








@end
