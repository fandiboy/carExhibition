//
//  CompareViewController.h
//  询车问价
//
//  Created by fandi on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplacementCar.h"


@interface CompareViewController : UIViewController


@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) DisplacementCar *displacementCar;

@property (nonatomic, strong) NSMutableArray *disArray;






@end
