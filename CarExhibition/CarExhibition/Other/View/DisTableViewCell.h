//
//  DisTableViewCell.h
//  询车问价
//
//  Created by fandi on 15/12/9.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplacementCar.h"

@interface DisTableViewCell : UITableViewCell


@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSUserDefaults *car;

@property (strong, nonatomic) IBOutlet UILabel *label4year;

@property (strong, nonatomic) IBOutlet UILabel *label4kind;

@property (strong, nonatomic) IBOutlet UILabel *label4Price;

@property (strong,nonatomic) DisplacementCar *displacementCar;

@property (strong, nonatomic) IBOutlet UISwitch *switch4Choose;

@end
