//
//  InsuranceController.h
//  询车问价
//
//  Created by fandi on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceController : UITableViewController

// 保险费合计
@property (nonatomic, strong) NSString *total;
// 第三责任险
@property (nonatomic, strong) NSString *duty;
// 玻璃破碎险
@property (nonatomic,strong) NSString *crush;
// 车身划痕险
@property (nonatomic, strong) NSString *scratch;
// 车辆损失险
@property (nonatomic, strong) NSString *loss;
// 自燃损失险
@property (nonatomic, strong) NSString *burn;
// 不计免赔特约险
@property (nonatomic, strong) NSString *deductible;
// 车上人员责任险
@property (nonatomic, strong) NSString *person;
// 全车盗抢险
@property (nonatomic, strong) NSString *steal;
// 无过责任险
@property (nonatomic, strong) NSString *unerring;




@end
