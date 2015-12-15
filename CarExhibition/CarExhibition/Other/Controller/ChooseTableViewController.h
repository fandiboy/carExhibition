//
//  ChooseTableViewController.h
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Car.h"

@interface ChooseTableViewController : UITableViewController

@property(nonatomic,retain)Car * car;
@property(nonatomic,retain)NSString * url;

@property (nonatomic, assign) BOOL result;



@end
