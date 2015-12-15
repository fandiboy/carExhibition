//
//  GuideListController.m
//  询车问价
//
//  Created by 刘宁 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "GuideListController.h"
#import "GuideModel.h"
#import "DepreciateCell.h"
#import "DepreciateDetailController.h"

@interface GuideListController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

static NSString *identifier = @"depreciateCell";

@implementation GuideListController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _dataArray;
}

// 解析列表数据
- (void)dataParseWithURL:(NSString *)URLString {
    // 开辟子线程，在子线程中访问数据，防止假死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.创建URL
        NSURL *url = [NSURL URLWithString:URLString];
        // 2.创建请求对象
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        // 3.建立会话
        NSURLSession *sesson = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                for (NSDictionary *dic in array) {
                    GuideModel *model = [GuideModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
                // 返回主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
            }
            
        }];
        // 使用resume方法启动任务
        [task resume];
    });
}

// 添加头部刷新
- (void)headerRereshing
{
    NSString * strPath = [NSString stringWithFormat:@"%@%d%@", self.urlHeader, 1, self.urlFooter];
    [self dataParseWithURL:strPath];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 如果连接拼接字符串是间隔是20，就这样拼接
    static int a = 0;
    a += 1;
    
    NSString * strPath = [NSString stringWithFormat:@"%@%d%@", self.urlHeader, a, self.urlFooter];
    [self dataParseWithURL:strPath];
    
    // 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"降价";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DepreciateCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    // 添加头部刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 添加尾部刷新
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 5.自动进入刷新状态
    [self.tableView headerBeginRefreshing];
    [self.tableView footerBeginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DepreciateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    GuideModel *model = self.dataArray[indexPath.row];
    cell.guideModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---didSelectRowAtIndexPath---");
    DepreciateModel *model = self.dataArray[indexPath.row];
    
    
    DepreciateDetailController *depreciateDetailVC = [[DepreciateDetailController alloc] init];
    depreciateDetailVC.url = model.url;
    depreciateDetailVC.title = model.title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:depreciateDetailVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
