//
//  KindTableViewController.m
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "KindTableViewController.h"
#import "KindTableViewCell.h"
#import "DisplacementCar.h"
#import "CarKind.h"
#import "CalculatorController.h"
#import "LNNavigationController.h"

@interface KindTableViewController ()


@property (nonatomic, strong) NSString *priceString;

@end

@implementation KindTableViewController



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
    self.view.backgroundColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    
    [self dataManager];
    
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"KindTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DisplacementCar *disCar = [DisplacementCar new];
    disCar = _dataArray[indexPath.section];
    cell.displacementCar = disCar;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CalculatorController *calculatorVC = [[CalculatorController alloc] init];
    
    DisplacementCar *disCar = [DisplacementCar new];
    disCar = _dataArray[indexPath.section];
    
    NSLog(@"%f",disCar.MinPrice);
    calculatorVC.priceString = [NSString stringWithFormat:@"%.2f",disCar.MinPrice];
    calculatorVC.name = disCar.name;
    calculatorVC.result = YES;
    
    LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:calculatorVC];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
