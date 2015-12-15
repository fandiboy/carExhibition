//
//  GarageController.h
//  询车问价
//
//  Created by 刘宁 on 15/12/2.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GarageController : UICollectionViewController
@property(nonatomic,retain)NSString * allUrl;
@property(nonatomic,strong)MBProgressHUD * HUD;
@property(nonatomic,assign)BOOL result;
@property(nonatomic,assign)int index;
@end
