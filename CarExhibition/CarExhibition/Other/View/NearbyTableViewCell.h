//
//  NearbyTableViewCell.h
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nearby4S.h"

@interface NearbyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image4Logo;

@property (strong, nonatomic) IBOutlet UILabel *label4ShortName;

@property (strong, nonatomic) IBOutlet UILabel *label4BrandList;

@property (strong, nonatomic) IBOutlet UILabel *label4Distance;

@property (strong, nonatomic) IBOutlet UILabel *label4Phone;

@property (strong, nonatomic) IBOutlet UILabel *label4Address;

@property (nonatomic, strong) Nearby4S *nearby;

@end
