//
//  ImageCollectionController.m
//  CarExhibition
//
//  Created by 刘宁 on 15/12/11.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "ImageCollectionController.h"
#import "ImageModel.h"
#import "ImageCollectionCell.h"

@interface ImageCollectionController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ImageCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _dataArray;
}

// 解析数据
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
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *picListListArray = dic[@"picList"];
            
            for (NSDictionary *dic in picListListArray) {
                ImageModel *model = [ImageModel new];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            // 返回主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.collectionView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 如果连接拼接字符串是间隔是1，就这样拼接
    static int a = 0;
    a += 1;
    
    NSString * strPath = [NSString stringWithFormat:@"%@%d%@", self.urlHeader, a, self.urlFooter];
    [self dataParseWithURL:strPath];
    
    // 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.collectionView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionView footerEndRefreshing];
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 添加头部刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 添加尾部刷新
//    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 5.自动进入刷新状态
    [self.collectionView headerBeginRefreshing];
    [self.collectionView footerBeginRefreshing];
    
    
    
    //    [self dataParseWithURL:@"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=1&pageSize=24&carLevel=2&cityId=1"];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.l
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%ld", self.dataArray.count);
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    // Configure the cell
    
    return cell;
}


@end
