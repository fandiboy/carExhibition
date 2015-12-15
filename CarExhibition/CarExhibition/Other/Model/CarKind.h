//
//  CarKind.h
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarKind : NSObject

// 汽车排量
@property (nonatomic, strong) NSString *displacement;
// 价格区间
@property (nonatomic, strong) NSString *guidePrice;
// 汽车图片
@property (nonatomic, strong) NSString *imagePath;
// 出厂年份
@property (nonatomic, strong) NSString *NewestYear;
// 汽车类型
@property (nonatomic, strong) NSString *level;






@end
