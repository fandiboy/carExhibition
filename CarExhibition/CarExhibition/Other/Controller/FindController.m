//
//  FindController.m
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "FindController.h"

@interface FindController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, strong) UITextField *numberText;

@end

#define ACCOUNT_MIN_CHARS 18

static NSString *identifier = @"cell";
@implementation FindController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    self.navigationItem.title = @"摇号查询";
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    // 设置tableView和导航栏无间隙
   //  self.automaticallyAdjustsScrollViewInsets=NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
            label.text = @"查询北京机动车摇号中签情况：";
            [cell addSubview:label];
            
            self.numberText = [[UITextField alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 30)];
            _numberText.placeholder = @"请输入您的申请编号";
            _numberText.keyboardType = UIKeyboardTypeDecimalPad;
            _numberText.borderStyle = UITextBorderStyleRoundedRect;
            self.numberText.delegate = self;
            [cell addSubview:_numberText];
        }
        if (indexPath.row == 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(50, 10, [UIScreen mainScreen].bounds.size.width-100, 40);
            [btn setTitle:@"查询" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:20];
            
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
            [btn setBackgroundColor:[UIColor colorWithRed:0.407 green:1.000 blue:0.662 alpha:1.000]];
            [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
            
            [btn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }
    }else if (indexPath.section == 1){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 30)];
        label.text = @"查询结果：";
        [cell addSubview:label];
        
        self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 30)];
        [cell addSubview:_resultLabel];
        
    }
    
    return cell;
}

// btn事件改变点击背景颜色
-(void)buttonClick:(UIButton *)button{
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)buttonClick1:(UIButton *)button{
    [button setBackgroundColor:[UIColor colorWithRed:0.407 green:1.000 blue:0.662 alpha:1.000]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (_numberText.text.length < 13) {
        [self alert];
    }else if (_numberText.text.length >= 13){
        
        _resultLabel.text = @"很抱歉！未中签！";
        _resultLabel.textColor = [UIColor redColor];
    }
    
}

// 封装alert
- (void)alert{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的编码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}


#pragma mark TextFieldDeleget

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // 最多输入18个数字
    NSInteger length = textField.text.length;
    if (length >= ACCOUNT_MIN_CHARS && string.length > 0) {
        return NO;
    }
    
    // 只能输入数字（没什么用）
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    return basic;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 90;
        }else if (indexPath.row == 1){
            return 60;
        }
    }
    return 40;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
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
