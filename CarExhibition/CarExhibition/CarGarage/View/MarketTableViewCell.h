//
//  MarketTableViewCell.h
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Market.h"

@interface MarketTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab4Title;
@property (weak, nonatomic) IBOutlet UILabel *lab4Time;
@property(nonatomic,retain)Market * market;
@end
