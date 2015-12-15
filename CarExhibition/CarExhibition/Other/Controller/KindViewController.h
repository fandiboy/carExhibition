//
//  KindViewController.h
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KindTableViewController.h"

@interface KindViewController : UIViewController

@property (nonatomic, strong) SUNSlideSwitchView *slideView;

@property (nonatomic, strong) KindTableViewController *vc1;
@property (nonatomic, strong) KindTableViewController *vc2;
@property (nonatomic, strong) KindTableViewController *vc3;
@property (nonatomic, strong) KindTableViewController *vc4;
@property (nonatomic, strong) KindTableViewController *vc5;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSArray *kindArray;

@end
