//
//  TaxTableViewController.h
//  询车问价
//
//  Created by fandi on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaxTableViewController : UITableViewController

// 购置税label（属性传值）
@property (nonatomic, strong) NSString *buyTax;
// 上牌费用
@property (nonatomic, strong) NSString *licensel;
// 车船使用费
@property (nonatomic, strong) NSString *use;
// 交强险
@property (nonatomic, strong) NSString *strong;

@end
