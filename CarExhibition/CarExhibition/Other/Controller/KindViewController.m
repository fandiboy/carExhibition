//
//  KindViewController.m
//  询车问价
//
//  Created by fandi on 15/12/8.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "KindViewController.h"

@interface KindViewController ()

@property (nonatomic, strong) KindTableViewController *kindVC;
@property (nonatomic, strong) NSMutableArray *kindVCArray;

@end

@implementation KindViewController
- (NSMutableArray *)kindVCArray {
    if (!_kindVCArray) {
        _kindVCArray = [NSMutableArray array];
    }
    return _kindVCArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self dataManager];
    self.view.backgroundColor = [UIColor colorWithRed:0.716 green:0.820 blue:0.009 alpha:1.000];
    

    // 204.0,210.0,211.0,220.0,231.0,260.0,280.0,290.0,333.0,335.0,350.0,420.0,435.0,450.0,500.0,
    
    self.slideView = [[SUNSlideSwitchView alloc] initWithFrame:self.view.frame];
    _slideView.slideSwitchViewDelegate = self;
    
    [self.view addSubview:_slideView];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 设置默认颜色
    self.slideView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    // 设置选中颜色
    self.slideView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    // 设置选中阴影的背景图片
    self.slideView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                  stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
//    NSLog(@"%@",_disCar);
//    NSArray *disArray = [self.disCar componentsSeparatedByString:@","];
//    NSLog(@"%@",disArray);
    
    for (int i = 0; i < self.kindArray.count; i++) {
        KindTableViewController *kindVC =  [[KindTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        kindVC.title = [NSString stringWithFormat:@"%@L", _kindArray[i]];
        kindVC.url = [NSString stringWithFormat:@"%@&displacement=%@",_url,_kindArray[i]];
    
        [self.kindVCArray addObject:kindVC];
    }
    
    // 更新UI
    [self.slideView buildUI];
    
    
}

// 设置一共多少个控制器
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return _kindVCArray.count - 1;
}

// 滑动视图切换视图控制器
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return self.kindVCArray[number];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
