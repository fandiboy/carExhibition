//
//  CarTableViewCell.h
//  询车问价
//
//  Created by 贺聪 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Car.h"

@interface CarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img4Car;
@property (weak, nonatomic) IBOutlet UILabel *lab4Name;
@property (weak, nonatomic) IBOutlet UILabel *lab4guidePrice;
@property (weak, nonatomic) IBOutlet UILabel *lab4Hq;
@property(nonatomic,strong)Car * car;
@end
