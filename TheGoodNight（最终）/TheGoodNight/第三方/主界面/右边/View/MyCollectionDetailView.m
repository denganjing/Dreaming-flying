//
//  MyCollectionDetailView.m
//  TheGoodNight
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MyCollectionDetailView.h"

@interface MyCollectionDetailView (){
    NSString *path;
}

@end

@implementation MyCollectionDetailView

- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadWeb];
    [self createNavButton];
}

-(void)createNavButton{
    //返回按钮
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 64, 44)];
    [leftbutton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(Leftback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    [self.view addSubview:leftbutton];
  
}

-(void)loadWeb{
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
    [self.view addSubview:webView];
    
    if (_index) {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"%ld", _index]ofType:@"html"];
        }
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:htmlString baseURL:nil];
    
    // 内容尺寸适应
    webView.scalesPageToFit = YES;
}


//返回的按钮
-(void)Leftback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
