//
//  DetailTableViewCell.h
//  询车问价
//
//  Created by 贺聪 on 15/12/5.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleCar.h"

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab4Title;
@property (weak, nonatomic) IBOutlet UILabel *lab4SpeedBox;
@property (weak, nonatomic) IBOutlet UILabel *lab4CombinedConsumption;
@property (weak, nonatomic) IBOutlet UILabel *lab4Price;
@property(nonatomic,retain)SaleCar * saleCar;
@end
