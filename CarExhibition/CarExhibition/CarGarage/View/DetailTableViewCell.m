//
//  DetailTableViewCell.m
//  询车问价
//
//  Created by 贺聪 on 15/12/5.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSaleCar:(SaleCar *)saleCar{
    _saleCar = saleCar;
    _lab4Title.text = [NSString stringWithFormat:@"%d %@",saleCar.yearName,saleCar.name];
    _lab4SpeedBox.text = saleCar.speedBox;
    
    _lab4CombinedConsumption.text = [NSString stringWithFormat:@"工信部油耗:%.1f",[saleCar.combinedConsumption floatValue]];
    if ([[NSString stringWithFormat:@"%.2f",saleCar.guidePrice] isEqualToString:saleCar.MinPrice]) {
         _lab4Price.text = [NSString stringWithFormat:@"%.2f万元",saleCar.guidePrice];
    }else{
        _lab4Price.text = [NSString stringWithFormat:@"%.2f万元|%@万元",saleCar.guidePrice,saleCar.MinPrice];
    }
    
}

@end
