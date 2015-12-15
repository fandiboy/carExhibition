//
//  DetailTableViewController.m
//  询车问价
//
//  Created by 贺聪 on 15/12/5.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DetailTableViewController.h"
#import "SaleCar.h"
#import "DetailTableViewCell.h"
#import "ImageRootController.h"

@interface DetailTableViewController ()<SUNSlideSwitchViewDelegate>
@property(nonatomic,retain)MBProgressHUD * HUD;
@property(nonatomic,retain)NSMutableArray * bigPicArray;
@property(nonatomic,retain)NSMutableDictionary * saleCarDic;
@property(nonatomic,retain)SaleCar * saleCar;
@property(nonatomic,assign)CGFloat currentSection;
@property(nonatomic,retain)NSMutableArray * displacementArray;
@property(nonatomic,retain)UILabel * typeLabel;
@property(nonatomic,retain)NSString * imagePath;
@property(nonatomic,retain)UIImageView * imgView;
@property(nonatomic,retain)NSMutableArray * allKeys;
@property(nonatomic,retain)SUNSlideSwitchView * slideSwitchView;

@end

@implementation DetailTableViewController

- (instancetype)init {
    return [super initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"chexun_backarrow_black"] style:UIBarButtonItemStylePlain target:self action:@selector(pop:)];
    //小菊花
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.backgroundColor = [UIColor clearColor];
    _HUD.dimBackground = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = [self setHeaderView];
    
    [self saleCarr];


//    [self bigImage];

}


-(void)pop:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goImage:(UITapGestureRecognizer *)sender {
//    NSLog(@"----跳转到图片页面：图片网址：%d", self.ID);
    ImageRootController *imageRootVC = [[ImageRootController alloc] init];
    imageRootVC.ID = self.ID;
    [self.navigationController pushViewController:imageRootVC animated:YES];
}

-(UIView *)setHeaderView{
    //头视图
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width / 11 * 7 + 220)];
    
    //头视图的图片
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / 11 * 7)];
    // 打开用户交互
    self.imgView.userInteractionEnabled = YES;
    // 给图片添加轻拍手势，点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goImage:)];
    [self.imgView addGestureRecognizer:tap];
    
    
    UIView * nameView = [[UIView alloc]initWithFrame:CGRectMake(0, _imgView.frame.size.height-30, [UIScreen mainScreen].bounds.size.width, 30)];
    nameView.backgroundColor = [UIColor blackColor];
    nameView.alpha = 0.7;
    
    //车名
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width / 2 - 30, 20)];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor whiteColor];

    //车型
    self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 + 30, 5, [UIScreen mainScreen].bounds.size.width / 2 - 26, 20)];
    _typeLabel.textAlignment = NSTextAlignmentLeft;
    _typeLabel.textColor = [UIColor lightGrayColor];
    _typeLabel.font = [UIFont systemFontOfSize:15];
    
    //logo
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 26, nameView.frame.origin.y - 11, 52, 52)];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
    backgroundView.layer.masksToBounds = YES;
    backgroundView.layer.cornerRadius = 26;
    
    self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 50, 50)];
    _logoImageView.layer.masksToBounds = YES;
    _logoImageView.layer.cornerRadius = 25;
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:_logoImagePath]];
    [backgroundView addSubview:_logoImageView];
    
    //详情和经销商
    self.slideSwitchView = [[SUNSlideSwitchView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width / 11 * 7, [UIScreen mainScreen].bounds.size.width, 220)];
    _slideSwitchView.slideSwitchViewDelegate = self;
    _slideSwitchView.backgroundColor = [UIColor whiteColor];
    // 设置默认状态下的颜色
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    // 设置选中的状态下的颜色
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    // 设置选中阴影的背景图片
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];

    self.marketTVC = [[MarketTableViewController alloc]initWithStyle:UITableViewStylePlain];
    _marketTVC.marketUrl = self.marketUrl;
    _marketTVC.title = @"行情";
    
    self.dealerTVC = [[DealerTableViewController alloc]initWithStyle:UITableViewStylePlain];
    _dealerTVC.dealerUrl = self.dealerUrl;
    _dealerTVC.title = @"经销商";
    
    [self.slideSwitchView buildUI];
    
    [headerView addSubview:_slideSwitchView];
    [nameView addSubview:_typeLabel];
    [nameView addSubview:_nameLabel];
    [_imgView addSubview:nameView];
    [headerView addSubview:_imgView];
    [headerView addSubview:backgroundView];
    
    return headerView;
}

-(void)bigImage{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //实际返回文本是HTML格式的,但是数据是json格式的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:self.bigPicUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"成功了");
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray * array = dic[@"picList"];
        self.bigPicArray = [NSMutableArray array];
        for (NSDictionary * dict in array) {
            self.bigPic = [[BigPic alloc]init];
            [_bigPic setValuesForKeysWithDictionary:dict];
            [_bigPicArray addObject:_bigPic];
            
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败了,%@",error);
    }];
}


-(void)saleCarr{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //实际返回文本是HTML格式的,但是数据是json格式的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:self.saleUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"成功了");
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray * array = dic[@"carModelList"];
        NSString * displacement = dic[@"displacement"];
        self.displacementArray = [displacement componentsSeparatedByString:@","].mutableCopy;
        [self.displacementArray removeLastObject];
        
        NSString * guidePrice = dic[@"guidePrice"];
        self.imagePath = dic[@"imagePath"];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_imagePath]];
        if ([_imagePath isEqualToString:@"http://file.chexun.com/images_index/album_h_12080.gif"]) {
            [_imgView sd_setImageWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/82d5ad6eddc451dab9b238dab1fd5266d01632be.jpg"]];
        }
        _typeLabel.text = dic[@"level"];
        
        self.saleCarDic = [NSMutableDictionary dictionary];
        
        for (NSString *str in _displacementArray) {
            [self.saleCarDic setObject:[NSMutableArray array] forKey:str];
        }
        for(NSDictionary * dict in array){
            self.saleCar = [[SaleCar alloc]init];
            [_saleCar setValuesForKeysWithDictionary:dict];
                [[self.saleCarDic objectForKey: [NSString stringWithFormat:@"%.1f",_saleCar.displacement]] addObject:_saleCar];
        }

        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:_saleCarDic];
        for (NSString * key in dict) {
            NSArray * array = dict[key];
            if (array.count == 0) {
                [_saleCarDic removeObjectForKey:key];
            }
        }
        _allKeys = [[_saleCarDic allKeys] sortedArrayUsingSelector:@selector(compare:)].mutableCopy;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败了,%@",error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _saleCarDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * array = _saleCarDic[_allKeys[section]];
    if(array != nil){
        [_HUD hide:YES];
    }
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray * array = _saleCarDic[_allKeys[indexPath.section]];
    _saleCar = array[indexPath.row];
    cell.saleCar = _saleCar;
    _nameLabel.text = _saleCar.seriesName;
    self.title = _saleCar.seriesName;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _allKeys[section];
}

#pragma mark -delegate
// 设定一共有几个视图控制器
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 2;
}

// 滑动视图切换视图控制器
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.marketTVC;
    }
    else if (number == 1) {
        return self.dealerTVC;
    }
    return nil;
    
}


// 设定选中按钮的时候跳转, 但是感觉并没有什么用
//- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number{
//    if (number == 0) {
//        _vc = self.marketTVC;
//    } else if (number == 1) {
//        _vc = self.dealerTVC;
//    }
//}



@end
