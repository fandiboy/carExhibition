//
//  DetailTableViewController.h
//  询车问价
//
//  Created by 贺聪 on 15/12/5.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigPic.h"
#import "MarketTableViewController.h"
#import "DealerTableViewController.h"
@interface DetailTableViewController : UITableViewController
@property(nonatomic,retain)NSString * marketUrl;//行情
@property(nonatomic,retain)NSString * saleUrl;//在售车型
@property(nonatomic,retain)NSString * dealerUrl;//经销商
@property(nonatomic,retain)NSString * bigPicUrl;//大图
@property(nonatomic,retain)NSString * appearanceUrl;//外观
@property(nonatomic,retain)NSString * interiorUrl;//内饰
@property(nonatomic,retain)NSString * detailUrl;//细节
@property(nonatomic,retain)NSString * illustrationUrl;//图解
@property(nonatomic,retain)NSString * officialUrl;//官方
@property(nonatomic,retain)NSString * showUrl;//车展
@property(nonatomic,retain)BigPic * bigPic;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UIImageView * logoImageView;//品牌logo
@property(nonatomic,retain)NSString * logoImagePath;
@property(nonatomic,retain)MarketTableViewController * marketTVC;//行情页面
@property(nonatomic,retain)DealerTableViewController * dealerTVC;//经销商页面

@property (nonatomic, assign) int ID;
@end
