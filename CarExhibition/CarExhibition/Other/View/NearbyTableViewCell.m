//
//  NearbyTableViewCell.m
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "NearbyTableViewCell.h"

@implementation NearbyTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNearby:(Nearby4S *)nearby{
    
    
    _nearby = nearby;
    
    _label4ShortName.text = nearby.dealerShortName;
    _label4Phone.text = nearby.salePhone;
    _label4BrandList.text = nearby.BrandList;
    [_image4Logo sd_setImageWithURL:[NSURL URLWithString:nearby.BrandLogoImage]];
    float dis = (nearby.Distance / 1000);
    _label4Distance.text = [NSString stringWithFormat:@"%.1fkm",dis];
    
    
    
}

@end
