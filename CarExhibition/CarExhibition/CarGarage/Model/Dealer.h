//
//  Dealer.h
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dealer : NSObject
@property(nonatomic,retain)NSString * BrandID;//品牌标示
@property(nonatomic,retain)NSString * BrandList;//品牌
@property(nonatomic,retain)NSString * BrandLogoImage;//logo
@property(nonatomic,retain)NSString * cityId;//城市标示
@property(nonatomic,retain)NSString * companyAddress;//公司地址
@property(nonatomic,retain)NSString * companyType;//公司类型
@property(nonatomic,retain)NSString * dealerId;//经销商标示
@property(nonatomic,retain)NSString * DealerLevel;//经销商级别
@property(nonatomic,retain)NSString * dealerName;//经销商名
@property(nonatomic,retain)NSString * dealerShortName;//经销商短名
@property(nonatomic,retain)NSString * dealerUrl;//经销商接口
@property(nonatomic,retain)NSString * Distance;//距离
@property(nonatomic,retain)NSString * ENGLISH_ALIAS;//英文名
@property(nonatomic,retain)NSString * GuidePrice;//指导价格
@property(nonatomic,retain)NSString * item;//项
@property(nonatomic,retain)NSString * Latitude;//纬度
@property(nonatomic,retain)NSString * Longitude;//经度
@property(nonatomic,retain)NSString * MaxPRICE;//最高价格
@property(nonatomic,retain)NSString * MEMBER_TYPE;//成员类型
@property(nonatomic,retain)NSString * memberType;//成员类型
@property(nonatomic,retain)NSString * MinPRICE;//最低价格
@property(nonatomic,retain)NSString * modelId;//模型标示
@property(nonatomic,retain)NSString * News3gUrl;//新闻3g接口
@property(nonatomic,retain)NSString * NewsID;//新闻标示
@property(nonatomic,retain)NSString * NewsTitle;//新闻抬头
@property(nonatomic,retain)NSString * NewsUrl;//新闻接口
@property(nonatomic,retain)NSString * provinceId;//省标示
@property(nonatomic,retain)NSString * regionalId;//区域标示
@property(nonatomic,retain)NSString * salePhone;//销售电话
@property(nonatomic,retain)NSString * seriesId;//系列标示
@property(nonatomic,retain)NSString * UpdateTime;//更新时间
@end
