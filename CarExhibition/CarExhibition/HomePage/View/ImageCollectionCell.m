//
//  ImageCollectionCell.m
//  CarExhibition
//
//  Created by 刘宁 on 15/12/11.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "ImageCollectionCell.h"

@interface ImageCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ImageCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ImageModel *)model {
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imagePath] placeholderImage:[UIImage imageNamed:@"Logo.png"]];
}

@end
