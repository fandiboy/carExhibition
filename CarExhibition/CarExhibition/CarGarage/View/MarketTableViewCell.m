//
//  MarketTableViewCell.m
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "MarketTableViewCell.h"

@implementation MarketTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMarket:(Market *)market{
    _market = market;
    
    _market.title = [_market.title stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];//去空格
    _lab4Title.text = _market.title;
    _lab4Time.text = _market.time;
}




@end
