//
//  GarageController.m
//  询车问价
//
//  Created by 刘宁 on 15/12/2.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "GarageController.h"
#import "CollectionViewCell.h"
#import "AllBrand.h"
#import "CollectionReusableView.h"
#import "CarTableViewController.h"
#import "ChooseTableViewController.h"
@interface GarageController ()
@property(nonatomic,strong)NSMutableDictionary * dataDic;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSArray * keyArray;
@property(nonatomic,strong)AllBrand * allBrand;
@property(nonatomic,strong)NSString * url;

@end

@implementation GarageController

- (void)viewDidLoad {
    [super viewDidLoad];
    //小菊花
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.backgroundColor = [UIColor clearColor];
    _HUD.dimBackground = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //实际返回文本是HTML格式的,但是数据是json格式的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:ALLCARURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"成功了");
        NSArray * array = [NSArray arrayWithArray:responseObject];
        NSDictionary * dic = array[0];
        NSArray * brandsArray = dic[@"brands"];
        self.dataDic = [NSMutableDictionary dictionary];
        
        for (NSDictionary * dict in brandsArray) {
            self.allBrand = [[AllBrand alloc]init];
            [self.allBrand setValuesForKeysWithDictionary:dict];
            
            if (_dataDic[_allBrand.letter] == nil) {
                self.dataArray = [NSMutableArray array];
                [_dataArray addObject:_allBrand];
                [_dataDic setObject:_dataArray forKey:_allBrand.letter];
            }else{
                [_dataArray addObject:_allBrand];
                [_dataDic setObject:_dataArray forKey:_allBrand.letter];
            }
        }
        NSArray * keyArray = [_dataDic allKeys];
        self.keyArray = [keyArray sortedArrayUsingSelector:@selector(compare:)];
    
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"失败了,%@",error);
    }];

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-20)/3,([UIScreen mainScreen].bounds.size.width-20)/3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(10, 30);//给头视图一个高度才能显示出来

    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.907 alpha:1.000];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _keyArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *key = _keyArray[section];
    NSArray * array = _dataDic[key];
    if(array != nil){
        [_HUD hide:YES];
    }
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *key = _keyArray[indexPath.section];
    NSArray * array = _dataDic[key];
    self.allBrand = array[indexPath.row];
    cell.allBrand = _allBrand;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(kind == UICollectionElementKindSectionHeader){
        CollectionReusableView * header = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.lab4title.text = _keyArray[indexPath.section];
        return header;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_index == 1){
        ChooseTableViewController *chooseVC = [[ChooseTableViewController alloc] initWithStyle:UITableViewStylePlain];
        NSString * key = _keyArray[indexPath.section];
        NSArray * array = _dataDic[key];
        self.allBrand = array[indexPath.row];
        chooseVC.url = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarBrandDetail.do?brandId=%d",_allBrand.ID];
        chooseVC.result = NO;
        [self.navigationController pushViewController:chooseVC animated:YES];
    }else if (_index == 2){
        ChooseTableViewController *chooseVC = [[ChooseTableViewController alloc] initWithStyle:UITableViewStylePlain];
        NSString * key = _keyArray[indexPath.section];
        NSArray * array = _dataDic[key];
        self.allBrand = array[indexPath.row];
        chooseVC.url = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarBrandDetail.do?brandId=%d",_allBrand.ID];
        chooseVC.result = YES;
        [self.navigationController pushViewController:chooseVC animated:YES];
    }else {
    CarTableViewController * carVC = [[CarTableViewController alloc]initWithStyle:UITableViewStylePlain];
    NSString * key = _keyArray[indexPath.section];
    NSArray * array = _dataDic[key];
    self.allBrand = array[indexPath.row];
    carVC.url = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarBrandDetail.do?brandId=%d",_allBrand.ID];
    
    [self.navigationController pushViewController:carVC animated:YES];
    }
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking


/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
