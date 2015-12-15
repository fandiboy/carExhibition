//
//  KindTableViewCell.m
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "KindTableViewCell.h"

@implementation KindTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setFrame:(CGRect)frame {
//    CGFloat frameX = 0;
//    CGFloat frameY = 0;
//    CGFloat frameW = 200;
//    CGFloat frameH = 44;
//    self.frame = CGRectMake(frameX, frameY, frameW, frameH);
//    [super setFrame:frame];
//}


- (void)setDisplacementCar:(DisplacementCar *)displacementCar{
    
    _displacementCar = displacementCar;
    
    _label4Price.text = [NSString stringWithFormat:@"%.1f万",displacementCar.MinPrice];
    
    _label4year.text = [NSString stringWithFormat:@"%lu",displacementCar.yearName];
    
    _label4kind.text = displacementCar.name;
    
}



@end
