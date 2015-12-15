//
//  HomePageModel.m
//  询车问价
//
//  Created by 刘宁 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel
//- (void)setValue:(id)value forKey:(NSString *)key {
//    [super setValue:value forKey:key];
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
//    if ([key isEqualToString:@"hq"]) {
//        _hq = value;
//    }
}


@end
