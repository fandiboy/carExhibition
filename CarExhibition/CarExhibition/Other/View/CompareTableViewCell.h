//
//  CompareTableViewCell.h
//  询车问价
//
//  Created by fandi on 15/12/4.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplacementCar.h"

@interface CompareTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *label4Name;


@property (strong, nonatomic) IBOutlet UILabel *label4Price;


@property (strong, nonatomic) IBOutlet UIImageView *image4pic;

@property (nonatomic, strong) DisplacementCar *displacementCar;

@end
