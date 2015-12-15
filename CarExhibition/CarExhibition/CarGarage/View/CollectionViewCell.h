//
//  CollectionViewCell.h
//  询车问价
//
//  Created by 贺聪 on 15/12/2.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllBrand.h"
@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img4Logo;
@property (weak, nonatomic) IBOutlet UILabel *lab4Brand;
@property(nonatomic,strong)AllBrand * allBrand;
@end
