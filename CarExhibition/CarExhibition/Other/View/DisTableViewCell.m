//
//  DisTableViewCell.m
//  询车问价
//
//  Created by fandi on 15/12/9.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DisTableViewCell.h"

@implementation DisTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.switch4Choose addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisplacementCar:(DisplacementCar *)displacementCar{
    
    _displacementCar = displacementCar;
    
    _label4Price.text = [NSString stringWithFormat:@"%.1f万",displacementCar.MinPrice];
    
    _label4year.text = [NSString stringWithFormat:@"%lu",displacementCar.yearName];
    
    _label4kind.text = displacementCar.name;
    
}


- (void)click:(UISwitch *)sender{
   NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:self.switch4Choose.isOn forKey:self.displacementCar.name];
    [userDefaults synchronize];
}


@end
