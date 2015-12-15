//
//  DepreciateController.m
//  询车问价
//
//  Created by 刘宁 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DepreciateController.h"

@interface DepreciateController ()
@property (nonatomic, strong) DepreciateListController *vc;
@end

@implementation DepreciateController

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"降价";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];;
    
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
    

    
    // 创建10个控制器
    self.vc1 = [[DepreciateListController alloc] init];
    self.vc1.title = @"紧凑车型";
    self.vc1.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=2&pageNo=";
    self.vc1.urlFooter = @"&pageSize=20&cityId=1";
    
    self.vc2 = [[DepreciateListController alloc] init];
    self.vc2.title = @"SUV";
    self.vc2.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=7&pageNo=";
    self.vc2.urlFooter = @"&pageSize=20&cityId=1";
    
    self.vc3 = [[DepreciateListController alloc] init];
    self.vc3.title = @"中型车";
    self.vc3.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=3&pageNo=";
    self.vc3.urlFooter = @"&pageSize=20&cityId=1";
    
    
    self.vc4 = [[DepreciateListController alloc] init];
    self.vc4.title = @"小型车";
    self.vc4.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=1&pageNo=";
    self.vc4.urlFooter = @"&pageSize=20&cityId=1";
    
    
    self.vc5 = [[DepreciateListController alloc] init];
    self.vc5.title = @"微型车";
    self.vc5.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=9&pageNo=";
    self.vc5.urlFooter = @"&pageSize=20&cityId=1";
    
    
    self.vc6 = [[DepreciateListController alloc] init];
    self.vc6.title = @"豪华车";
    self.vc6.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=4&pageNo=";
    self.vc6.urlFooter = @"&pageSize=20&cityId=1";
    
    
    self.vc7 = [[DepreciateListController alloc] init];
    self.vc7.title = @"中大型车";
    self.vc7.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=5&pageNo=";
    self.vc7.urlFooter = @"&pageSize=20&cityId=1";
    
    
    self.vc8 = [[DepreciateListController alloc] init];
    self.vc8.title = @"跑车";
    self.vc8.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=6&pageNo=";
    self.vc8.urlFooter = @"&pageSize=20&cityId=1";
    
    
    self.vc9 = [[DepreciateListController alloc] init];
    self.vc9.title = @"MPV";
    self.vc9.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarCutPrice.do?carLevel=8&pageNo=";
    self.vc9.urlFooter = @"&pageSize=20&cityId=1";
    
    // 调用更新UI的方法
    [self.slideSwitchView buildUI];
    
    // 设置右边菜单
//    self.numberOfItemsInRow = 3;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}


#pragma mark -delegate
// 设定一共有几个视图控制器
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 9;
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
    } else if (number == 6) {
        return self.vc7;
    } else if (number == 7) {
        return self.vc8;
    } else if (number == 8) {
        return self.vc9;
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
    } else if (number == 6) {
        _vc = self.vc7;
    } else if (number == 7) {
        _vc = self.vc8;
    } else if (number == 8) {
        _vc = self.vc9;
    }
}


@end
