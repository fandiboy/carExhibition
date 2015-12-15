//
//  BigPic.m
//  询车问价
//
//  Created by 贺聪 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "BigPic.h"

@implementation BigPic
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _imagePath];
}
@end
