//
//  SinaLoginViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SinaLoginViewController.h"
@interface SinaLoginViewController ()

@end

@implementation SinaLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //微博登录界面
    [self _weiboLogin];
    //普通登录的界面
    [self _webLogin];
}

-(void)_weiboLogin{
    //关闭按钮
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth -44, 20, 34, 34)];
    [button setImage:[UIImage imageNamed:@"iphone_close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(CloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
   
    //文字label
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 70, KScreenWidth-150, 20)];
    label.text=@"你可以用以下的账号登录";
    label.font =[UIFont systemFontOfSize:12];

    [self.view addSubview:label];
    
    //微博的登录按钮
    UIButton *weibobutton=[[UIButton alloc]initWithFrame:CGRectMake(60, 110, 240, 32)];
    [weibobutton setImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
    [weibobutton addTarget:self action:@selector(LoginWeiboButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weibobutton];

    //QQ的登录按钮
    UIButton *QQbobutton=[[UIButton alloc]initWithFrame:CGRectMake(60, 150, 240, 32)];
    [QQbobutton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [self.view addSubview:QQbobutton];

    
}


//关闭当前页面的按钮的方法
-(void)CloseButton:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
     }


//跳转到微博界面
-(void)LoginWeiboButton:(UIButton*)button{

    SinaWeibo *sinaweibo =[self weibo];
    //当isAuthValid 为no的时候，就说明没有验证，或者验证失败
    self.view.userInteractionEnabled =YES;
    if (sinaweibo.isAuthValid == NO) {
        //验证
        [sinaweibo logIn];
    }
    //发一个请求,网络请求数据格式拼接到URL后面
    NSDictionary *paras = @{@"count":@"20"};

}


//当前社区的账号登录
-(void)_webLogin{
    //文字label
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 250, 250, 20)];
    label.text=@"或使用现在移动社区帐号登录";
    label.font =[UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    
    //Email
    UITextField *email =[[UITextField alloc]initWithFrame:CGRectMake(45, 280, 250, 30)];
    //设置边框样式
    email.borderStyle =UITextBorderStyleRoundedRect;
    //水印提示
    email.placeholder =@"Email";
    //输入框是否有叉号，在什么时候显示，用于一次性删除输入框的内容
    email.clearButtonMode =UITextFieldViewModeAlways;
    [self.view addSubview:email ];
    
    //密码
    UITextField *psw =[[UITextField alloc]initWithFrame:CGRectMake(45, 320, 250, 30)];
    //设置边框样式
    psw.borderStyle =UITextBorderStyleRoundedRect;
    //水印提示
    psw.placeholder =@"密码";
    //输入的字符变成点，加密
    psw.secureTextEntry =YES;
    
    [self.view addSubview:psw ];

    //注册
    UIButton *button1 =[[UIButton alloc]initWithFrame:CGRectMake(45, 360, 104, 32)];
    //添加背景色，就不会挡住字体
    [button1 setBackgroundImage:[UIImage imageNamed:@"secondary_bttn"] forState:UIControlStateNormal];
    [button1 setTitle:@"注册" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [self.view addSubview:button1];

    //登录
    UIButton *button2 =[[UIButton alloc]initWithFrame:CGRectMake(180, 360, 105, 32)];
    //添加背景色，就不会挡住字体
    [button2 setBackgroundImage:[UIImage imageNamed:@"primary_bttn"] forState:UIControlStateNormal];
    [button2 setTitle:@"登录" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(SinaWeibo *)weibo{
    AppDelegate *dele =(AppDelegate*)[UIApplication sharedApplication].delegate;
    return dele.sinaweibo;
    
}

- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
}

-(void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    
}


@end
