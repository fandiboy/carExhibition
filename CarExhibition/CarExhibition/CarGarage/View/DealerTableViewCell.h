//
//  DealerTableViewCell.h
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dealer.h"
#import <CoreLocation/CoreLocation.h>
@interface DealerTableViewCell : UITableViewCell<CLLocationManagerDelegate>
@property(nonatomic,retain)Dealer * dealer;
@property (weak, nonatomic) IBOutlet UILabel *lab4DealerShortName;
@property (weak, nonatomic) IBOutlet UILabel *lab4Distance;
@property (weak, nonatomic) IBOutlet UILabel *lab4CompanyAddress;

@end
