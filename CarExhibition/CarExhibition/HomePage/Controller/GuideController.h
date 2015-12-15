//
//  GuideController.h
//  询车问价
//
//  Created by 刘宁 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuideListController.h"

@interface GuideController : UIViewController
@property (nonatomic, retain)SUNSlideSwitchView *slideSwitchView;

@property (nonatomic, strong) GuideListController *vc1;
@property (nonatomic, strong) GuideListController *vc2;
@property (nonatomic, strong) GuideListController *vc3;
@end
