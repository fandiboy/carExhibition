//
//  CarTableViewCell.m
//  询车问价
//
//  Created by 贺聪 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CarTableViewCell.h"

@implementation CarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCar:(Car *)car{
    _car = car;
    _img4Car.image = [UIImage imageNamed:@"placeholder.png"];
    [_img4Car sd_setImageWithURL:[NSURL URLWithString:car.imagePath] placeholderImage:[UIImage imageNamed:@"Logo"]];
    _lab4Name.text = car.name;
    if (![car.hq isEqualToString:@""] && car.hq != nil) {
        _lab4Hq.text = [NSString stringWithFormat:@"降:%@", car.hq];
    }
    _lab4guidePrice.text = car.guidePrice;
}



@end
