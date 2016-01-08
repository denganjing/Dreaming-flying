//
//  WebViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButton];
        [self loadWeb];
}

-(void)createButton{
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 44, 44)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Backbutton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIButton *messageButton =[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2-30, 20, 44, 44)];
    [messageButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Backbutton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageButton];
    
    
    

}
-(void)loadWeb{
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
    [self.view addSubview:webView];
 NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_webstring]];
    
 [webView loadRequest:request];
   
    
    // 内容尺寸适应
    webView.scalesPageToFit = YES;
}

-(void)Backbutton{
[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
