//
//  HomeController.m
//  询车问价
//
//  Created by 刘宁 on 15/12/2.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "HomeController.h"
#import "DepreciateController.h"
#import "GuideController.h"
#import "CityController.h"
#import <MessageUI/MessageUI.h>
#import <objc/runtime.h>

@interface HomeController ()< FFNavbarMenuDelegate>

@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) FFNavbarMenu *menu;
@property (nonatomic, strong) HomeCollectionController *vc;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 用来存储成员变量的个数
//    unsigned int outCont = 0;
//    // 获取HomeCollectionController类里面所有成员变量
//    Ivar *ivars = class_copyIvarList([HomeCollectionController class], &outCont);
//    // unsigned定义的变量用%zd占位符来承接
//    NSLog(@"outCont == %zd", outCont);
//    for (int i = 0; i < outCont; i++) {
//        // 取出i所对应的成员变量,指针的地址依次往后访问
//        Ivar ivar = *(ivars + i); // 或者Ivar ivar = ivars[i];
//        // 获取属性的名字
//        const char *name = ivar_getName(ivar);
//        // 获取属性的类型
//        const char *type = ivar_getTypeEncoding(ivar);
////          @(name) 等价于 [NSString stringWithUTF8String:name];
//        NSString *key = @(name);
//        // 通过key获取对应的value，KVC
//        id value = [self valueForKeyPath:key];
//        
//        NSLog(@"%s %s", name, type);
//    }
//    // 释放内存
//    free(ivars);
    
    
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
    flowLayoutVC.itemSize = CGSizeMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.width / 2 + 80);
    // 设置内边距
    flowLayoutVC.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 创建10个控制器
    self.vc1 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc1.title = @"值得买";
    self.vc1.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc1.urlFooter = @"&pageSize=24&carLevel=1&cityId=1";
    
    self.vc2 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc2.title = @"紧凑车型";
    self.vc2.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc2.urlFooter = @"&pageSize=24&carLevel=2&cityId=1";
    
    self.vc3 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc3.title = @"SUV";
    self.vc3.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc3.urlFooter = @"&pageSize=24&carLevel=7&cityId=1";

    
    self.vc4 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc4.title = @"中型车";
    self.vc4.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc4.urlFooter = @"&pageSize=24&carLevel=3&cityId=1";

    
    self.vc5 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc5.title = @"小型车";
    self.vc5.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc5.urlFooter = @"&pageSize=24&carLevel=1&cityId=1";

    
    self.vc6 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc6.title = @"微型车";
    self.vc6.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc6.urlFooter = @"&pageSize=24&carLevel=9&cityId=1";

    
    self.vc7 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc7.title = @"豪华车";
    self.vc7.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc7.urlFooter = @"&pageSize=24&carLevel=5&cityId=1";

    
    self.vc8 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc8.title = @"中大型车";
    self.vc8.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc8.urlFooter = @"&pageSize=24&carLevel=4&cityId=1";

    
    self.vc9 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc9.title = @"跑车";
    self.vc9.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc9.urlFooter = @"&pageSize=24&carLevel=8&cityId=1";

    
    self.vc10 = [[HomeCollectionController alloc] initWithCollectionViewLayout:flowLayoutVC];
    self.vc10.title = @"MPV";
    self.vc10.urlHeader = @"http://api.tool.chexun.com/mobile/buyCarSeriesInfo.do?pageNo=";
    self.vc10.urlFooter = @"&pageSize=24&carLevel=6&cityId=1";
    
    // 调用更新UI的方法
    [self.slideSwitchView buildUI];

    // 设置右边菜单
    self.numberOfItemsInRow = 3;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}


#pragma mark -delegate
// 设定一共有几个视图控制器
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 10;
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
    } else if (number == 9) {
        return self.vc10;
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
    } else if (number == 9) {
        _vc = self.vc10;
    }
    

}


- (FFNavbarMenu *)menu {
    if (_menu == nil) {
        FFNavbarMenuItem *item1 = [FFNavbarMenuItem ItemWithTitle:@"搜索车系" icon:[UIImage imageNamed:@"0"]];
        FFNavbarMenuItem *item2 = [FFNavbarMenuItem ItemWithTitle:@"降价行情" icon:[UIImage imageNamed:@"1"]];
        FFNavbarMenuItem *item3 = [FFNavbarMenuItem ItemWithTitle:@"新车导购" icon:[UIImage imageNamed:@"2"]];
        FFNavbarMenuItem *item4 = [FFNavbarMenuItem ItemWithTitle:@"车型对比" icon:[UIImage imageNamed:@"3"]];
        FFNavbarMenuItem *item5 = [FFNavbarMenuItem ItemWithTitle:@"历史记录" icon:[UIImage imageNamed:@"4"]];
        FFNavbarMenuItem *item6 = [FFNavbarMenuItem ItemWithTitle:@"城市选择" icon:[UIImage imageNamed:@"5"]];
        
        
        _menu = [[FFNavbarMenu alloc] initWithItems:@[item1,item2,item3,item4,item5,item6] width:self.view.frame.size.width maximumNumberInRow:_numberOfItemsInRow];
        _menu.backgroundColor = [UIColor whiteColor];
        _menu.separatarColor = [UIColor lightGrayColor];
        _menu.textColor = [UIColor blackColor];
        _menu.delegate = self;
    }
    return _menu;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.menu) {
        [self.menu dismissWithAnimation:NO];
    }
}

// 点击事件方法
- (void)openMenu:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if (self.menu.isOpen) {
        [self.menu dismissWithAnimation:YES];
    } else {
        [self.menu showInNavigationController:self.navigationController];
    }
}

#pragma mark -代理中的方法
// 菜单显示出来处理
- (void)didShowMenu:(FFNavbarMenu *)menu {
    UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.5;
    backgroundView.tag = 1001;
    [self.vc.view addSubview:backgroundView];
    
    
    [self.navigationItem.rightBarButtonItem setTitle:@"隐藏"];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

// 菜单消失的时候的处理
- (void)didDismissMenu:(FFNavbarMenu *)menu {
    [self.navigationItem.rightBarButtonItem setTitle:@"菜单"];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    UIView *bacView = (UIView *)[self.view viewWithTag:1001];
    [bacView removeFromSuperview];
}

// 点击菜单要做的处理
- (void)didSelectedMenu:(FFNavbarMenu *)menu atIndex:(NSInteger)index {
    
    FFNavbarMenuItem *item = menu.items[index];
    
    if ([item.title isEqualToString:@"搜索车系"]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"大哥，俺们家不卖车了" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [av show];
    }
    if ([item.title isEqualToString:@"降价行情"]) {
        DepreciateController *deprecitaVC = [DepreciateController new];
        LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:deprecitaVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    if ([item.title isEqualToString:@"新车导购"]) {
        GuideController *deprecitaVC = [GuideController new];
        LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:deprecitaVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
    if ([item.title isEqualToString:@"车型对比"]) {
        
    }
    if ([item.title isEqualToString:@"历史记录"]) {
        
    }
    if ([item.title isEqualToString:@"城市选择"]) {
        CityController *cityVC = [CityController new];
        LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:cityVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.menu = nil;
}



@end
