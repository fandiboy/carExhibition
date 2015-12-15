//
//  CollectionReusableView.m
//  询车问价
//
//  Created by 贺聪 on 15/12/3.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lab4title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        [self addSubview:_lab4title];
    }
    return self;
}
@end
