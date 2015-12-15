//
//  HomePageModel.h
//  询车问价
//
//  Created by 刘宁 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject


@property (nonatomic, strong) NSNumber *brandId;
@property (nonatomic, copy) NSString *brandLogo;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *english;
@property (nonatomic, copy) NSString *guidePrice;
@property (nonatomic, copy) NSConstantString *hq;
@property (nonatomic, copy) NSConstantString *hqurl;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *name;

@end
