//
//  DepreciateDetailController.m
//  询车问价
//
//  Created by 刘宁 on 15/12/7.
//  Copyright © 2015年 刘宁. All rights reserved.
//

#import "DepreciateDetailController.h"
#import <Social/Social.h>  // 系统的库

@interface DepreciateDetailController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DepreciateDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:_webView];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)share {
    // 判断平台是否可用
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        
        NSLog(@"可用");
        
        // 创建一个SLComposeViewController
        SLComposeViewController *compose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        // 添加文字
        [compose setInitialText:[NSString stringWithFormat:@"来买车，找寻车问价,此车名字:%@ 详情链接:%@", self.title, self.url]];
        
        // 添加图片
        [compose addImage:[UIImage imageNamed:@"1"]];
        
        // 弹出分享界面
        [self presentViewController:compose animated:YES completion:nil];
        
        //
        compose.completionHandler = ^ (SLComposeViewControllerResult resule){
            if (resule == SLComposeViewControllerResultCancelled) {
                NSLog(@"用户点击了取消");
            }else{
                NSLog(@"用户点击了发布");
            }
        };
        
    }else{
        NSLog(@"查看您是否设置了新浪微博账号. 设置->新浪微博->配置账号");
    }
}


@end
