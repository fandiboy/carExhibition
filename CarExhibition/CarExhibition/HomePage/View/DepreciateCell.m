//
//  DepreciateCell.m
//  询车问价
//
//  Created by 刘宁 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DepreciateCell.h"

@interface DepreciateCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayAgoLabel;
@end

@implementation DepreciateCell


- (void)setDepreciateModel:(DepreciateModel *)depreciateModel {
    _depreciateModel = depreciateModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:depreciateModel.imagePath] placeholderImage:[UIImage imageNamed:@"Logo.png"]];
    self.detailLabel.text = depreciateModel.title;
    NSString *tempTime = [depreciateModel.time substringToIndex:10];
    self.dayAgoLabel.text = tempTime;
}

- (void)setGuideModel:(GuideModel *)guideModel {
    _guideModel = guideModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:guideModel.imagePath] placeholderImage:[UIImage imageNamed:@"Logo.png"]];
    self.detailLabel.text = guideModel.title;
    NSString *tempTime = [guideModel.date substringToIndex:10];
    self.dayAgoLabel.text = tempTime;

}

@end
