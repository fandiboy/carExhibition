//
//  InsuranceController.m
//  询车问价
//
//  Created by fandi on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "InsuranceController.h"

@interface InsuranceController ()

// 保险费合计
@property (nonatomic, strong) UILabel *totalLabel;
// 第三责任险
@property (nonatomic, strong) UITextField *dutyText;
// 玻璃破碎险
@property (nonatomic,strong) UITextField *crushText;
// 车身划痕险
@property (nonatomic, strong) UITextField *scratchText;
// 车辆损失险
@property (nonatomic, strong) UILabel *lossLabel;
// 自燃损失险
@property (nonatomic, strong) UILabel *burnLabel;
// 不计免赔特约险
@property (nonatomic, strong) UILabel *deductibleLabel;
// 车上人员责任险
@property (nonatomic, strong) UILabel *personLabel;
// 全车盗抢险
@property (nonatomic, strong) UILabel *stealLabel;
// 无过责任险
@property (nonatomic, strong) UILabel *unerringLabel;



@end

@implementation InsuranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    if (indexPath.row == 0) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"商业保险总计：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _totalLabel.text = _total;
        _totalLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_totalLabel];
    }else if (indexPath.row == 1){
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"第三者责任险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        
        self.dutyText = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _dutyText.text = _duty;
        _dutyText.textAlignment = NSTextAlignmentRight;
        _dutyText.borderStyle = UITextBorderStyleRoundedRect;
        [cell addSubview:_dutyText];
        
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1001;
        [cell addSubview:switch1];
         */
        
    }else if (indexPath.row == 2){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"玻璃破碎险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        self.crushText = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _crushText.textAlignment = NSTextAlignmentRight;
        _crushText.text = _crush;
        _crushText.borderStyle = UITextBorderStyleRoundedRect;
        [cell addSubview:_crushText];
        
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1002;
        [cell addSubview:switch1];
         */
    }else if (indexPath.row == 3){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"车身划痕险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        
        self.scratchText = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _scratchText.text = _scratch;
        _scratchText.borderStyle = UITextBorderStyleRoundedRect;
        _scratchText.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_scratchText];
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1003;
        [cell addSubview:switch1];
         */
    }else if (indexPath.row == 4){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"车辆损失险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        self.lossLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _lossLabel.text = _loss;
        _lossLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_lossLabel];
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1004;
        [cell addSubview:switch1];
         */
        
    }else if (indexPath.row == 5){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"自燃损失险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        self.burnLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _burnLabel.text = _burn;
        _burnLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_burnLabel];
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1005;
        [cell addSubview:switch1];
         */
        
    }else if (indexPath.row == 6){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"不计免赔特约险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        self.deductibleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _deductibleLabel.text = _deductible;
        _deductibleLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_deductibleLabel];
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1006;
        [cell addSubview:switch1];
        */
    }else if (indexPath.row == 7){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"车上人员责任险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _personLabel.text = _person;
        _personLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_personLabel];
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1007;
        [cell addSubview:switch1];
        */
    }else if (indexPath.row == 8){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"全车盗抢险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
       self.stealLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _stealLabel.text = _steal;
        _stealLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_stealLabel];
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1008;
        [cell addSubview:switch1];
        */
    }else if (indexPath.row == 9){
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 180, 30)];
        label1.text = @"无过责任险：";
        label1.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label1];
        self.unerringLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 175, 5, 95, 30)];
        _unerringLabel.text = _unerring;
        _unerringLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:_unerringLabel];
        /*
        UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 5, 50, 30)];
        [switch1 setOn:YES];
        [switch1 addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
        switch1.tag = 1009;
        [cell addSubview:switch1];
        */
    }
    
    
    
    
    return cell;
}


- (void)switchClick:(UISwitch *)sender{
    
    
    BOOL isSwitchOn = [sender isOn];
    
    if (isSwitchOn) {
        if (sender.tag == 1001) {
            
            self.dutyText.userInteractionEnabled = YES;
            self.dutyText.textColor = [UIColor blackColor];
            
        }else if (sender.tag == 1002){
            self.crushText.userInteractionEnabled = YES;
            self.crushText.textColor = [UIColor blackColor];
            
        }else if (sender.tag == 1003){
            self.scratchText.userInteractionEnabled = YES;
            self.scratchText.textColor = [UIColor blackColor];
            
        }else if (sender.tag == 1004){
            self.lossLabel.textColor = [UIColor blackColor];
            
        }else if (sender.tag == 1005){
            self.burnLabel.textColor = [UIColor blackColor];
            
        }else if (sender.tag == 1006){
            self.deductibleLabel.textColor = [UIColor blackColor];
            
        }else if (sender.tag == 1007){
            self.personLabel.textColor = [UIColor blackColor];
            
        }else if (sender.tag == 1008){
            self.stealLabel.textColor = [UIColor blackColor];
        }else if (sender.tag == 1009){
            self.unerringLabel.textColor = [UIColor blackColor];
        }
    }else{
        if (sender.tag == 1001) {
            self.dutyText.userInteractionEnabled = NO;
            self.dutyText.textColor = [UIColor lightGrayColor];
        }else if (sender.tag == 1002){
            self.crushText.userInteractionEnabled = NO;
            self.crushText.textColor = [UIColor lightGrayColor];
            
        }else if (sender.tag == 1003){
            self.scratchText.userInteractionEnabled = NO;
            self.scratchText.textColor = [UIColor lightGrayColor];
            
        }else if (sender.tag == 1004){
            self.lossLabel.textColor = [UIColor lightGrayColor];
            
        }else if (sender.tag == 1005){
            self.burnLabel.textColor = [UIColor lightGrayColor];
            
        }else if (sender.tag == 1006){
            self.deductibleLabel.textColor = [UIColor lightGrayColor];
            
        }else if (sender.tag == 1007){
            self.personLabel.textColor = [UIColor lightGrayColor];
        }else if (sender.tag == 1008){
            self.stealLabel.textColor = [UIColor lightGrayColor];
        }else if (sender.tag == 1009){
            self.unerringLabel.textColor = [UIColor lightGrayColor];
        }
    }
    
    
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
