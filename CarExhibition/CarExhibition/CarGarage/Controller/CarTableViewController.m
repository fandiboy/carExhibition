//
//  CarTableViewController.m
//  询车问价
//
//  Created by 贺聪 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CarTableViewController.h"
#import "CarTableViewCell.h"
#import "GarageController.h"
#import "DetailTableViewController.h"

@interface CarTableViewController ()
@property(nonatomic,strong)NSString * imagePath;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSString * brandName;
@property(nonatomic,strong)NSString * companyName;
@property(nonatomic,strong)NSMutableArray * seriesListArray;
@property(nonatomic,strong)NSMutableDictionary * dataDic;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)NSString * brandId;
@property(nonatomic,strong)MBProgressHUD * HUD;
@end

@implementation CarTableViewController

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
//        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 42, 42)];
//        _imgView.layer.masksToBounds = YES;
//        _imgView.layer.cornerRadius = 21;
//        [_imgView sd_setImageWithURL:[NSURL URLWithString:_imagePath]];
//        [self.navigationController.navigationBar addSubview:_imgView];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败了,%@",error);
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"chexun_backarrow_black"]  style:UIBarButtonItemStylePlain target:self action:@selector(pop:)];
    
    
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 42, 42)];
//    _imgView.layer.masksToBounds = YES;
//    _imgView.layer.cornerRadius = 21;
////    [_imgView sd_setImageWithURL:[NSURL URLWithString:_imagePath]];
//    [self.navigationController.navigationBar addSubview:_imgView];
//
//}

//-(void)viewDidAppear:(BOOL)animated{
//    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 42, 42)];
//    _imgView.layer.masksToBounds = YES;
//    _imgView.layer.cornerRadius = 21;
//    [self.navigationController.navigationBar addSubview:_imgView];
//}

//-(void)viewWillDisappear:(BOOL)animated{
//    [self.imgView removeFromSuperview];
//}




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
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _dataArray[section][@"companyName"];
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = _dataArray[indexPath.section];
    NSArray * array = dic[@"seriesList"];
    self.car = array[indexPath.row];
    DetailTableViewController * detailVC = [[DetailTableViewController alloc] init];
    detailVC.nameLabel.text = _car.name;
    detailVC.logoImagePath = _imagePath;
    
    detailVC.marketUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarHq.do?cityId=1&seriesId=%d",_car.id];
    detailVC.saleUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarSeriesPage.do?seriesId=%d&cityId=1",_car.id];
    detailVC.dealerUrl = [NSString stringWithFormat:@"http://dealer.chexun.com/api/GetDealersInfo3.ashx?sortType=2&cityId=1&SeriesID=%d&pageSize=50&longitude=116.337529&latitude=40.029412&pageIndex=1",_car.id];
    detailVC.bigPicUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=out&pageNo=1&pageSize=20",_car.id];
    detailVC.appearanceUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=out&pageNo=1&pageSize=20",_car.id];
    detailVC.interiorUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=in&pageNo=1&pageSize=20",_car.id];
    detailVC.detailUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=detail&pageNo=1&pageSize=20",_car.id];
    detailVC.illustrationUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=disa&pageNo=1&pageSize=20",_car.id];
    detailVC.officialUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=office&pageNo=1&pageSize=20",_car.id];
    detailVC.showUrl = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=show&pageNo=1&pageSize=20",_car.id];
    
    detailVC.ID = _car.id;
//    [self.navigationController pushViewController:detailVC animated:YES];
    LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:detailVC];
    [self presentViewController:nav animated:YES completion:nil];
}



@end
