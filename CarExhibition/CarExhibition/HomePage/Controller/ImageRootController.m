//
//  ImageRootController.m
//  CarExhibition
//
//  Created by 刘宁 on 15/12/11.
//  Copyright © 2015年 刘宁. All rights reserved.
// 存放各种图片

#import "ImageRootController.h"

@interface ImageRootController ()
@property (nonatomic, strong) ImageCollectionController *vc;
@end

@implementation ImageRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.初始化滑动视图控件
    self.slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:self.view.frame];
    // 2.给滑动视图设置代理，记住本视图控制器要遵循代理
    _slideSwitchView.slideSwitchViewDelegate = self;
    // 3.添加到视图上
    [self.view addSubview:self.slideSwitchView];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 设置默认状态下的颜色
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    // 设置选中的状态下的颜色
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    // 设置选中阴影的背景图片
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    UICollectionViewFlowLayout *flowLayoutVC = [[UICollectionViewFlowLayout alloc] init];
    flowLayoutVC.itemSize = CGSizeMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.width / 2 - 20);
    // 设置内边距
    flowLayoutVC.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 创建10个控制器
    self.vc1 = [[ImageCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc1.title = @"  外观  ";
    self.vc1.urlHeader = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=out&pageNo=", _ID];
    self.vc1.urlFooter = @"&pageSize=20";
    
    self.vc2 = [[ImageCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc2.title = @"  内饰  ";
    self.vc2.urlHeader = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=in&pageNo=", _ID];
    self.vc2.urlFooter = @"&pageSize=20";
    
    self.vc3 = [[ImageCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc3.title = @"  细节  ";
    self.vc3.urlHeader = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=detail&pageNo=", _ID];
    self.vc3.urlFooter = @"&pageSize=20";
    
    self.vc4 = [[ImageCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc4.title = @"  图解  ";
    self.vc4.urlHeader = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=disa&pageNo=", _ID];
    self.vc4.urlFooter = @"&pageSize=20";
    
    self.vc5 = [[ImageCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc5.title = @"  官方图  ";
    self.vc5.urlHeader = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=office&pageNo=", _ID];
    self.vc5.urlFooter = @"&pageSize=20";
    
    self.vc6 = [[ImageCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc6.title = @"  车展  ";
    self.vc6.urlHeader = [NSString stringWithFormat:@"http://api.tool.chexun.com/mobile/buyCarPicList.do?seriesId=%d&albumType=show&pageNo=", _ID];
    self.vc6.urlFooter = @"&pageSize=20";
    
    // 调用更新UI的方法
    [self.slideSwitchView buildUI];
}

#pragma mark -delegate
// 设定一共有几个视图控制器
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 6;
}

// 滑动视图切换视图控制器
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else if (number == 4) {
        return self.vc5;
    } else if (number == 5) {
        return self.vc6;
    } else {
        return nil;
    }
}

// 设定选中按钮的时候跳转, 但是感觉并没有什么用
- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    if (number == 0) {
        _vc = self.vc1;
    } else if (number == 1) {
        _vc = self.vc2;
    } else if (number == 2) {
        _vc = self.vc3;
    } else if (number == 3) {
        _vc = self.vc4;
    } else if (number == 4) {
        _vc = self.vc5;
    } else if (number == 5) {
        _vc = self.vc6;
    }
}


@end
