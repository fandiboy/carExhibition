//
//  DealerTableViewController.h
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dealer.h"

@interface DealerTableViewController : UITableViewController
@property(nonatomic,retain)Dealer * dealer;
@property(nonatomic,retain)NSString * dealerUrl;
@end
