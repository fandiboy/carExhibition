        //
//  OtherViewController.m
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "OtherViewController.h"
#import "OtherCollectionViewCell.h"
#import "CalculatorController.h"
#import "FindController.h"
#import "NearbyController.h"
#import "CompareViewController.h"
#import "DepreciateController.h"

@interface OtherViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) BOOL result;


@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"OtherCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OtherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *labelArray = @[@"降价车型",@"车型对比",@"摇号查询",@"附近4S店",@"购车计算器",@"清除缓存"];
    cell.label4Name.text = labelArray[indexPath.row];
    
    NSArray *imageArray = @[@"热门车型图标",@"车型对比图标",@"摇号查询图标",@"附近4S店图标",@"购车计算器图标",@"设置图标"];
    NSString *string = imageArray[indexPath.row];
    cell.image4Icon.image = [UIImage imageNamed:string];

    
    
    // Configure the cell
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        DepreciateController *deperciateVC = [[DepreciateController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:deperciateVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    
    if (indexPath.row == 1) {
        
        if (self.result == NO) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"此功能正在装修，敬请期待！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *acion = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:acion];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }else{
            
            CompareViewController *compareVC = [[CompareViewController alloc] init];
            [self.navigationController pushViewController:compareVC animated:YES];
        }
    }
    
    
    if (indexPath.row == 2) {
        FindController *findVC = [[FindController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:findVC animated:YES];
    }
    
    
    if (indexPath.row == 3) {
        NearbyController *nearbyVC = [[NearbyController alloc] init];
        [self.navigationController pushViewController:nearbyVC animated:YES];
        
    }
    
    
    if (indexPath.row == 4) {
        
        CalculatorController *calculatorVC = [[CalculatorController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:calculatorVC animated:YES];
        
    }
    
    if (indexPath.row == 5) {
        
        [self alert];
        
    }
    
    
}

// 封装alert
- (void)alert{
    float size = [[SDImageCache sharedImageCache] getSize];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"确定要清除%.1fM缓存？",size/1024/1024] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"alert执行方法");
        
        
        
        // 清除缓存
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

// 定义每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 3 - 1, [UIScreen mainScreen].bounds.size.width / 3 - 1);
    
    
}








#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

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
