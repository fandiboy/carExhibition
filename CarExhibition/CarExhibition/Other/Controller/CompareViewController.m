//
//  CompareViewController.m
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CompareViewController.h"
#import "GarageController.h"
#import "CompareTableViewCell.h"

@interface CompareViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CompareViewController


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        NSLog(@"sdadsasdasd");
        
        
    }
    
    return self;
}


- (void)dataManager{
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 创建URL
        NSURL *url = [NSURL URLWithString:self.url];
        NSLog(@"%@",self.url);
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"车型对比";
    
    
    [self dataManager];
    // 添加车型button
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 50);
    [addBtn setBackgroundColor:[UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000]];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [addBtn setTitle:@"+添加车型" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    // 添加TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 注册
    [_tableView registerNib:[UINib nibWithNibName:@"CompareTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    // 添加底部view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
    view.backgroundColor = [UIColor colorWithWhite:0.462 alpha:1.000];
    [self.view addSubview:view];
    
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, 10, 20)];
    numberLabel.text = @"1";
    numberLabel.textColor = [UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000];
    [view addSubview:numberLabel];
    
    UILabel *number2Label = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 20, 20)];
    number2Label.text = @"/2";
    number2Label.textColor = [UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000];
    [view addSubview:number2Label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(80, 5, [UIScreen mainScreen].bounds.size.width / 3, 40);
    [btn setBackgroundColor:[UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000]];
    [btn setTitle:@"开始对比" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(compareClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2.5 + 100, 5, [UIScreen mainScreen].bounds.size.width / 3.5, 38);
    btn2.layer.borderColor = [UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000].CGColor;
    btn2.layer.borderWidth = 2;
    [btn2 setTitle:@"分享给朋友" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn2];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    
    
    [self dataManager];
}


- (void)addClick:(UIButton *)sender{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    GarageController *garageVC = [[GarageController alloc] initWithCollectionViewLayout:layout];
    garageVC.navigationItem.title = @"选择车型";
    garageVC.index = 2;
    
    [self.navigationController pushViewController:garageVC animated:YES];
    
    
    
}


- (void)compareClick:(UIButton *)sender{
    
    
    
    
}



- (void)shareClick:(UIButton *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"分享给好友" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"分享到朋友圈" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}



#pragma mark -- tableViewDeleget & tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _disArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DisplacementCar *disCar = [DisplacementCar new];
    disCar = _dataArray[indexPath.row];
    
    cell.displacementCar = disCar;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
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
