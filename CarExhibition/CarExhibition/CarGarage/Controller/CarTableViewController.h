//
//  CarTableViewController.h
//  询车问价
//
//  Created by 贺聪 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllBrand.h"
#import "Car.h"

@interface CarTableViewController : UITableViewController
@property(nonatomic,retain)Car * car;
@property(nonatomic,retain)NSString * url;
@end
