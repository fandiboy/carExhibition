//
//  ImageRootController.h
//  CarExhibition
//
//  Created by 刘宁 on 15/12/11.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionController.h"

@interface ImageRootController : UIViewController
@property (nonatomic, retain)SUNSlideSwitchView *slideSwitchView;

@property (nonatomic, strong) ImageCollectionController *vc1;
@property (nonatomic, strong) ImageCollectionController *vc2;
@property (nonatomic, strong) ImageCollectionController *vc3;
@property (nonatomic, strong) ImageCollectionController *vc4;
@property (nonatomic, strong) ImageCollectionController *vc5;
@property (nonatomic, strong) ImageCollectionController *vc6;

@property (nonatomic, assign) int ID;
@end
