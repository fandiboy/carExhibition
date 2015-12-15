//
//  CalculatorController.m
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CalculatorController.h"
#import "GarageController.h"
#import "TaxTableViewController.h"
#import "InsuranceController.h"
#import "OtherViewController.h"

@interface CalculatorController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *bareCarText;

@property (nonatomic, strong) TaxTableViewController *taxVC;

@property (nonatomic, strong) UILabel *taxLabel;

@property (nonatomic, strong) UILabel *insuranceLabel;

@property (nonatomic, strong) UILabel *allLabel;


@end

static NSString *identifier = @"cell";

@implementation CalculatorController
// 懒加载
- (TaxTableViewController *)taxVC{
    if (!_taxVC) {
        _taxVC = [TaxTableViewController new];
    }
    return _taxVC;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    self.navigationItem.title = @"购车计算器";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if (_result == YES) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    if (indexPath.section == 0) {
        if (_result == YES) {
            
            cell.textLabel.text = self.name;
        }else{
            
            cell.textLabel.text = @"添加车型（必选）";
        }
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"裸  车  价：";
            self.bareCarText = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 125, 5, 100, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 25, 5, 20, 30)];
            label.text = @"万";
            [cell addSubview:label];
            if (_result == YES) {
                self.bareCarText.text = self.priceString;
            }else{
                 _bareCarText.placeholder = @"例：21.58";
            }
            _bareCarText.textAlignment = NSTextAlignmentRight;
            _bareCarText.keyboardType = UIKeyboardTypeDecimalPad;
            _bareCarText.borderStyle = UITextBorderStyleRoundedRect;
            _bareCarText.delegate = self;
            
            [cell addSubview:_bareCarText];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 195, 5, 50, 30);
            [btn setTitle:@"查询" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 7;
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            btn.layer.borderWidth = 1;
            [btn addTarget:self action:@selector(queryClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"各项税费：";
            self.taxLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 67, 5, 62, 30)];
            _taxLabel.textAlignment = NSTextAlignmentRight;
            [cell addSubview:_taxLabel];
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"商业保险：";
            self.insuranceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 67, 5, 62, 30)];
            _insuranceLabel.textAlignment = NSTextAlignmentRight;
            [cell addSubview:_insuranceLabel];
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"全款总价：";
            self.allLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 105, 5, 100, 30)];
            _allLabel.textAlignment = NSTextAlignmentRight;
            _allLabel.textColor = [UIColor redColor];
            [cell addSubview:_allLabel];
        }
    }else if (indexPath.section == 2){
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, 5, 200, 30);
        
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:btn];
    }
    
    
    return cell;
}

- (void)returnClick:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)queryClick:(UIButton *)sender{
    if (_bareCarText.text.length != 0) {
        
        // 购置税
        float bareCar = [_bareCarText.text intValue] / 11.7;
        // 总税
        float all = bareCar + (0.05 + 0.048 + 0.096);
        
        _taxLabel.text = [NSString stringWithFormat:@"%.2f万",all];
        
        InsuranceController *insuranceVC = [[InsuranceController alloc] init];
        insuranceVC.duty = @"971元";
        insuranceVC.crush = @"660元";
        insuranceVC.scratch = @"900元";
        insuranceVC.person = @"50元";
        float loss = [_bareCarText.text intValue] * 10000 / 83;
        float burn = [_bareCarText.text intValue] * 10000 / 666;
        float deductible = loss / 5 + ([insuranceVC.duty intValue] / 5);
        float steal = [_bareCarText.text intValue] * 10000 / 100 ;
        float unerring = [insuranceVC.duty intValue] / 5;
        float total = (loss + burn + deductible + steal + unerring + [insuranceVC.duty intValue] + [insuranceVC.crush intValue] + [insuranceVC.scratch intValue] + [insuranceVC.person intValue]) / 10000 ;
        
        _insuranceLabel.text = [NSString stringWithFormat:@"%.2f万",total];
        
        // 全款总价
        float all2 = all + total + [_bareCarText.text intValue];
        _allLabel.text = [NSString stringWithFormat:@"%.2f万",all2];
        
        [_bareCarText resignFirstResponder];
    }else{
        [self alert];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (_result == YES) {
            
        }else{
            
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
            GarageController *garageVC = [[GarageController alloc] initWithCollectionViewLayout:layout];
            garageVC.navigationItem.title = @"选择车型";
            garageVC.index = 1;
            [self.navigationController pushViewController:garageVC animated:YES];
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 1) {
            
            if (_bareCarText.text.length != 0) {
                
                TaxTableViewController *taxVC = [[TaxTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
                
                // 属性传值
                float bareCar = [_bareCarText.text intValue] / 11.7 * 10000;
                
                taxVC.buyTax = [NSString stringWithFormat:@"%.0f元",bareCar];
                taxVC.licensel = @"500元";
                taxVC.use = @"480元";
                taxVC.strong = @"950元";
                
                
                
                [self.navigationController pushViewController:taxVC animated:YES];
            }else{
                [self alert];
            }
            
        }else if (indexPath.row == 2){
            
            if (_bareCarText.text.length != 0) {
                
                InsuranceController *insuranceVC = [[InsuranceController alloc] init];
                
                insuranceVC.duty = @"971元";
                insuranceVC.crush = @"660元";
                insuranceVC.scratch = @"900元";
                insuranceVC.person = @"50元";
                
                // 车辆损失险
                float loss = [_bareCarText.text intValue] * 10000 / 83;
                insuranceVC.loss = [NSString stringWithFormat:@"%.0f元",loss];
                
                // 自燃损失险
                float burn = [_bareCarText.text intValue] * 10000 / 666;
                insuranceVC.burn = [NSString stringWithFormat:@"%.0f元",burn];
                
                // 不计免赔特约险
                float deductible = loss / 5 + ([insuranceVC.duty intValue] / 5);
                insuranceVC.deductible = [NSString stringWithFormat:@"%.0f元",deductible];
                
                // 全车盗抢险
                float steal = [_bareCarText.text intValue] * 10000 / 100 ;
                insuranceVC.steal = [NSString stringWithFormat:@"%.0f元",steal];
                
                // 无过责任险
                float unerring = [insuranceVC.duty intValue] / 5;
                insuranceVC.unerring = [NSString stringWithFormat:@"%.0f元",unerring];
                
                // 保险总价
                float total = loss + burn + deductible + steal + unerring + [insuranceVC.duty intValue] + [insuranceVC.crush intValue] + [insuranceVC.scratch intValue] + [insuranceVC.person intValue];
                insuranceVC.total = [NSString stringWithFormat:@"%.0f元",total];
                
                
                [self.navigationController pushViewController:insuranceVC animated:YES];
            }else{
                [self alert];
            }
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


// 封装alert
- (void)alert{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入裸车价！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}



//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    
//
//}




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
