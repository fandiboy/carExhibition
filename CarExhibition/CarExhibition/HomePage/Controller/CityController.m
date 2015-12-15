//
//  CityController.m
//  询车问价
//
//  Created by 刘宁 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CityController.h"
#import "CityModel.h"

@interface CityController ()
// 存放所有大写字母的数组
@property (nonatomic, strong) NSMutableArray *letterArray;
// 存放所有城市的字典，key是大写字母，每一个value是一个数组
@property (nonatomic, strong) NSMutableDictionary *cityDic;
// 热门城市
@property (nonatomic, strong) NSMutableArray *hotCityArray;
// 除了热门城市中的所有城市
@property (nonatomic, strong) NSMutableArray *allCityArray;
@end

static NSString *identfier = @"cell";

@implementation CityController

- (NSMutableArray *)letterArray {
    if (!_letterArray) {
        _letterArray = [NSMutableArray array];
    }
    return _letterArray;
}

- (NSMutableArray *)hotCityArray {
    if (!_hotCityArray) {
        _hotCityArray = [NSMutableArray array];
    }
    return _hotCityArray;
}

- (NSMutableArray *)allCityArray {
    if (!_allCityArray) {
        _allCityArray = [NSMutableArray array];
    }
    return _allCityArray;
}


- (NSMutableDictionary *)cityDic {
    if (!_cityDic) {
        _cityDic = [NSMutableDictionary dictionaryWithCapacity:20];
    }
    return _cityDic;
}

- (void)dataParse {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://dealer.chexun.com/api/GetCityInfo.ashx?Hot=1"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                // 所有分组
                NSString *groupStr = dic[@"Letter"];
                for (NSUInteger i = 0; i < groupStr.length; i+=2) {
                    char c = [groupStr characterAtIndex:i];
                    [self.letterArray addObject:[NSString stringWithFormat:@"%c", c]];
                }
                
                // 拿到所有城市
                NSArray *generalArray = dic[@"general"];
                // 遍历所有城市首字母,把相同的城市放到一个
//                for (int i = 0; i < self.letterArray.count; i++) {
//                    NSMutableArray *array = [NSMutableArray array];
//                    for (NSDictionary *dic in generalArray) {
//                        CityModel *cityModel = [CityModel new];
//                        [cityModel setValuesForKeysWithDictionary:dic];
//                        if ([cityModel.Letter isEqualToString:_letterArray[i]]) {
//                            [array[i] addObject:cityModel];
//                        }
//                    }
//                    [self.cityDic setValue:array[i] forKey:@"A"];
//                }
                
                
                // 创建一个数字，每一个元素用于存放每一个分组,初始化数组中的每一个元素
                NSMutableArray *array = [NSMutableArray array];
                for (int i = 0; i < _letterArray.count; i++) {
                    array[i] = [NSMutableArray array];;
                }
                for (int i = 0; i < generalArray.count; i++) {
                    NSDictionary *dic = generalArray[i];
                    CityModel *cityModel = [CityModel new];
                    [cityModel setValuesForKeysWithDictionary:dic];
                    for (int j = 1; j < _letterArray.count; j++) {
                        if ([cityModel.Letter isEqualToString:_letterArray[j]]) {
                            [array[j] addObject:cityModel];
                        }
                    }
                }
                // 把所有存放分组的数组改变存放到字典中
                for (int i = 1; i < _letterArray.count; i++) {
                    [self.cityDic setValue:array[i] forKey:_letterArray[i]];
                }
                
                
                // 拿到热门城市
                NSArray *hotArray = dic[@"hotcity"];
                for (NSDictionary *dic in hotArray) {
                    CityModel *cityModel = [CityModel new];
                    [cityModel setValuesForKeysWithDictionary:dic];
                    [self.hotCityArray addObject:cityModel];
                }
                [self.cityDic setValue:_hotCityArray forKey:@"*"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });

            }
        }];
        [task resume];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];;
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identfier];
    
    [self dataParse];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _letterArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *str = _letterArray[section];
    NSArray *array = self.cityDic[str];
    NSLog(@"%ld------", _letterArray.count);
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *str = _letterArray[indexPath.section];
    NSArray *array = self.cityDic[str];
    CityModel *model = array[indexPath.row];
    cell.textLabel.text = model.cityName;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _letterArray[section];
}

// 快速索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _letterArray;
}


@end
