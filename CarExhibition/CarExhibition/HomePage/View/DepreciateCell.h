//
//  DepreciateCell.h
//  询车问价
//
//  Created by 刘宁 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DepreciateModel.h"
#import "GuideModel.h"

@interface DepreciateCell : UITableViewCell
@property (nonatomic, strong) DepreciateModel *depreciateModel;
@property (nonatomic, strong) GuideModel *guideModel;
@end
