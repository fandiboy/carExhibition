//
//  ImageCollectionController.h
//  CarExhibition
//
//  Created by 刘宁 on 15/12/11.
//  Copyright © 2015年 刘宁. All rights reserved.
//  展示所有图片的视图

#import <UIKit/UIKit.h>

@interface ImageCollectionController : UICollectionViewController
@property (nonatomic, copy) NSString *urlHeader;
@property (nonatomic, copy) NSString *urlFooter;
@end
