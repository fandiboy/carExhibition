//
//  SaleCar.h
//  询车问价
//
//  Created by 贺聪 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleCar : NSObject
@property(nonatomic,retain)NSString * active;
@property(nonatomic,retain)NSString * brandId;
@property(nonatomic,retain)NSString * brandName;//品牌
@property(nonatomic,retain)NSString * combinedConsumption;//工信部油耗
@property(nonatomic,assign)CGFloat displacement;//排量
@property(nonatomic,assign)CGFloat guidePrice;//原价
@property(nonatomic,assign)int id;
@property(nonatomic,retain)NSString * imagePath;//图片网址
@property(nonatomic,retain)NSString * MinPrice;//现价
@property(nonatomic,retain)NSString * name;//名字
@property(nonatomic,assign)int pvCount;
@property(nonatomic,assign)int seriesId;
@property(nonatomic,retain)NSString * seriesName;//型号
@property(nonatomic,retain)NSString * speedBox;//速箱
@property(nonatomic,assign)int yearName;//年代

@end
