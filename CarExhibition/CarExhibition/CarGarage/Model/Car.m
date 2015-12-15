//
//  Car.m
//  询车问价
//
//  Created by 贺聪 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "Car.h"

@implementation Car
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%d", _name,_id];
}
@end
