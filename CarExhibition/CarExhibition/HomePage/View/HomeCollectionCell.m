//
//  HomeCollectionCell.m
//  询车问价
//
//  Created by 刘宁 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "HomeCollectionCell.h"

@interface HomeCollectionCell ()
// 车的头像
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
// 品牌标志
@property (weak, nonatomic) IBOutlet UIImageView *iconBrandView;
// 汽车名字
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
// 价格区域
@property (weak, nonatomic) IBOutlet UILabel *priceAreaLabel;
// 降价
@property (weak, nonatomic) IBOutlet UILabel *reducePriceLabel;
@end

@implementation HomeCollectionCell


- (void)setHomeModel:(HomePageModel *)homeModel {
    
    _homeModel = homeModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:homeModel.imgPath] placeholderImage:[UIImage imageNamed:@"Logo.png"]];
    [self.iconBrandView sd_setImageWithURL:[NSURL URLWithString:homeModel.brandLogo] placeholderImage:nil];
    self.carNameLabel.text = homeModel.name;
    self.priceAreaLabel.text = homeModel.guidePrice;
    if (homeModel.hq.length != 0) {
        self.reducePriceLabel.text = [NSString stringWithFormat:@"降%@", homeModel.hq];
    }
}

@end
