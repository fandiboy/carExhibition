//
//  CompareTableViewCell.m
//  询车问价
//
//  Created by fandi on 15/12/4.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CompareTableViewCell.h"

@implementation CompareTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisplacementCar:(DisplacementCar *)displacementCar{
    
    _displacementCar = displacementCar;
    
    _label4Name.text = displacementCar.name;
    
    _label4Price.text = [NSString stringWithFormat:@"%.2f万",displacementCar.MinPrice];
    
    [_image4pic sd_setImageWithURL:[NSURL URLWithString:displacementCar.imagePath]];
}


@end
