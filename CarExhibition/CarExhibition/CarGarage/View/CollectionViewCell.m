//
//  CollectionViewCell.m
//  询车问价
//
//  Created by 贺聪 on 15/12/2.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setAllBrand:(AllBrand *)allBrand{
    _allBrand = allBrand;
    _lab4Brand.text = allBrand.name;
    [_img4Logo sd_setImageWithURL:[NSURL URLWithString:_allBrand.imagePath] placeholderImage:[UIImage imageNamed:@"Logo"]];
}


@end
