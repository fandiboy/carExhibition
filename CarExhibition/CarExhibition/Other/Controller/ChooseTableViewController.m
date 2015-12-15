//
//  ChooseTableViewController.m
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "ChooseTableViewController.h"
#import "CarTableViewCell.h"
#import "GarageController.h"
#import "DetailTableViewController.h"
#import "KindViewController.h"
#import "KindTableViewController.h"
#import "DisplacementController.h"

@interface ChooseTableViewController ()
@property(nonatomic,strong)NSString * imagePath;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSString * brandName;
@property(nonatomic,strong)NSString * companyName;
@property(nonatomic,strong)NSMutableArray * seriesListArray;
@property(nonatomic,strong)NSMutableDictionary * dataDic;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)NSString * brandId;
@property(nonatomic,strong)MBProgressHUD * HUD;

@property (nonatomic, strong) NSString *disCar;

@property (nonatomic, strong) NSData *tempData;

@property (nonatomic, strong) NSString *disUrl;

@property (nonatomic, strong) NSMutableArray *displaceArray;
@property (nonatomic, strong) NSMutableDictionary *dicArray;
@end

@implementation ChooseTableViewController

- (NSMutableArray *)displaceArray {
    if (!_displaceArray) {
        _displaceArray = [NSMutableArray array];
    }
    return _displaceArray;
}
- (NSMutableDictionary *)dicArray {
    if (!_dicArray) {
        _dicArray = [NSMutableDictionary dictionaryWithCapacity:20];
    }
    return _dicArray;
}



- (void)dataManager{
    
    
    self.disUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarModelListBySeriesId.do?seriesId=%d&cityId=1",_car.id];
    // 创建URL
    NSURL *url = [NSURL URLWithString:self.disUrl];
    NSLog(@"%@",self.disUrl);
    // 创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 建立会话
    NSURLSession *sesson = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        NSLog(@"%@",data);
        _tempData = data;
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",dic);
            NSString *string = dic[@"displacement"];
            self.disCar = string;
            NSLog(@"%@",string);
            
        }
        
    }];
    
    [task resume];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //小菊花
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.backgroundColor = [UIColor clearColor];
    _HUD.dimBackground = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"CarTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //实际返回文本是HTML格式的,但是数据是json格式的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:self.url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"成功了");
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray * array = dic[@"companyList"];
        self.imagePath = dic[@"imagePath"];
        self.brandName = dic[@"brandName"];
        self.dataArray = [NSMutableArray array];
        for (NSDictionary * dic in array) {
            self.companyName = dic[@"companyName"];
            NSArray * seriesListArray = dic[@"seriesList"];
            self.seriesListArray = [NSMutableArray array];
            for (NSDictionary * dict in seriesListArray) {
                self.car = [Car new];
                [_car setValuesForKeysWithDictionary:dict];
                [_seriesListArray addObject:_car];
            }
            self.dataDic = [NSMutableDictionary dictionary];
            [_dataDic setObject:_seriesListArray forKey:@"seriesList"];
            [_dataDic setObject:_companyName forKey:@"companyName"];
            [_dataArray addObject:_dataDic];
        }
        self.title = _brandName;
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 2, 40, 40)];
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 20;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_imagePath]];
        [self.navigationController.navigationBar addSubview:_imgView];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败了,%@",error);
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(pop:)];
    
    [self dataManager];
    
    
}

-(void)pop:(UIBarButtonItem *)sender{
    GarageController * garageVC = [[GarageController alloc]init];
    [garageVC.HUD hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary * dic = _dataArray[section];
    NSArray * array = dic[@"seriesList"];
    if(array != nil){
        [_HUD hide:YES];
    }
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary * dic = _dataArray[indexPath.section];
    NSArray * array = dic[@"seriesList"];
    self.car = array[indexPath.row];
    cell.car = _car;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *strURL = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarModelListBySeriesId.do?seriesId=%d&cityId=1",_car.id];
    [self dataParse:strURL andWithCarId:_car.id];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _dataArray[section][@"companyName"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.imgView removeFromSuperview];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.result == NO) {
        NSDictionary * dic = _dataArray[indexPath.section];
        NSArray * array = dic[@"seriesList"];
        self.car = array[indexPath.row];
        
        KindViewController *kindVC = [[KindViewController alloc] init];
        kindVC.url = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarModelListBySeriesId.do?seriesId=%d&cityId=1",_car.id];
        //    NSLog(@"%@",self.disCar);
        //    kindVC.disCar = self.disCar;
        //    [self dataParse:kindVC.url];
        NSString *key  = [NSString stringWithFormat:@"%d", self.car.id];
        NSArray *indexArray = self.dicArray[key];
        kindVC.kindArray = indexArray;
        [self.navigationController pushViewController:kindVC animated:YES];
        
    }else{
        NSDictionary * dic = _dataArray[indexPath.section];
        NSArray * array = dic[@"seriesList"];
        self.car = array[indexPath.row];
        
        DisplacementController *disVC = [[DisplacementController alloc] initWithStyle:UITableViewStyleGrouped];
        disVC.url = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarModelListBySeriesId.do?seriesId=%d&cityId=1",_car.id];
        
        NSString *key  = [NSString stringWithFormat:@"%d", self.car.id];
        NSArray *indexArray = self.dicArray[key];
        
        
        disVC.disArray = indexArray;
        
        disVC.navigationItem.title = @"选择排量";
        
        [self.navigationController pushViewController:disVC animated:YES];
        
    }
    
    
}

- (void)dataParse:(NSString *)strURL andWithCarId:(NSInteger) ID{
    //    NSString *URLString = [NSString stringWithFormat:@"%@&displacement=%@", self.url, array[]];
    // 创建URL
    NSURL *url = [NSURL URLWithString:strURL];
    // 创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 建立会话
    NSURLSession *sesson = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *string = dic[@"displacement"];
            //            NSLog(@"%@",string);
            self.displaceArray = [string componentsSeparatedByString:@","].mutableCopy;
            [self.dicArray setValue:_displaceArray forKey:[NSString stringWithFormat:@"%ld", ID]];
            self.displaceArray = nil;
        }
        
    }];
    
    [task resume];
}



@end
