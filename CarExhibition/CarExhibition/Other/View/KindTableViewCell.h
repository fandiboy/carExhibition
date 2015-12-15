//
//  KindTableViewCell.h
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplacementCar.h"

@interface KindTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *label4year;

@property (strong, nonatomic) IBOutlet UILabel *label4kind;

@property (strong, nonatomic) IBOutlet UILabel *label4Price;

@property (strong,nonatomic) DisplacementCar *displacementCar;

@end
