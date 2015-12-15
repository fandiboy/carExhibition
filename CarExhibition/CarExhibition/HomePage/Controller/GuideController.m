//
//  GuideController.m
//  询车问价
//
//  Created by 刘宁 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "GuideController.h"

@interface GuideController ()
@property (nonatomic, strong) GuideListController *vc;
@end

@implementation GuideController

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
    self.vc1 = [[GuideListController alloc] init];
    self.vc1.title = @"     多车导购        ";
    self.vc1.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarGetGuideNews.do?&pageNo=";
    self.vc1.urlFooter = @"&pageSize=20&type=2";
    
    self.vc2 = [[GuideListController alloc] init];
    self.vc2.title = @"      单车导购        ";
    self.vc2.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarGetGuideNews.do?&pageNo=";
    self.vc2.urlFooter = @"&pageSize=20&type=2";
    
    self.vc3 = [[GuideListController alloc] init];
    self.vc3.title = @"      新车导购       ";
    self.vc3.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarGetGuideNews.do?&pageNo=";
    self.vc3.urlFooter = @"&pageSize=20&type=3";
    
    [self.slideSwitchView buildUI];
}

#pragma mark -delegate
// 设定一共有几个视图控制器
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 3;
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
    }
}


@end
