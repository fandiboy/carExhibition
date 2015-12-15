//
//  AllBrand.m
//  询车问价
//
//  Created by 贺聪 on 15/12/2.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "AllBrand.h"

@implementation AllBrand
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = [value intValue];
    }
}

-(NSString *)description{
    return _name;
}
@end
