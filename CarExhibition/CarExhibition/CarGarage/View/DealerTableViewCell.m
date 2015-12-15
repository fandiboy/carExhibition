//
//  DealerTableViewCell.m
//  询车问价
//
//  Created by 贺聪 on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DealerTableViewCell.h"

@implementation DealerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDealer:(Dealer *)dealer{
    _dealer = dealer;
    _lab4DealerShortName.text = _dealer.dealerShortName;
    _lab4Distance.text = [NSString stringWithFormat:@"%.1fKM",[_dealer.Distance floatValue]/1000] ;
    _lab4CompanyAddress.text = [_dealer.companyAddress stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

//    stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding
//    CLLocationDegrees latitude = [_dealer.Latitude doubleValue];
//    CLLocationDegrees longitude = [_dealer.Longitude doubleValue];
//    CLLocation * location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
//
//    //编码/反编码 将经度和纬度转换为位置信息
//    CLGeocoder * geoCoder = [CLGeocoder new];//创建编码/反编码对象
//    //反编码:通过CLLocation对象获取到一个CLPlacemark对象
//    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        //取到反编码的最后一个对象
//        //placemark 就是一个具体的位置信息
//        CLPlacemark * placeMark = placemarks.lastObject;
//        _lab4CompanyAddress.text = [NSString stringWithFormat:@"地址:%@",placeMark.name];
//    }];

}



@end
