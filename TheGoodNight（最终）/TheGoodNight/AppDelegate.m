//
//  AppDelegate.m
//  TheGoodNight
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //创建window
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen ].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
  
    //初始化微博对象
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:KAppkey appSecret:KAppSecretKey appRedirectURI:KRedirectURl andDelegate:self];
    
    // 从偏好设置中 获取信息
    // 当第一次授权登陆成功之后，下次就从本地文件中读取授权信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        // accessToken OAuth 认证的令牌
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        
        // expirationDate 失效日期
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        
        // 用户ID
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
   

    
    
    //创建菜单控制器
    MenuViewController *menu=[[MenuViewController alloc]init];
    menu.view.backgroundColor =[UIColor clearColor];
    _window.rootViewController =menu;
    return YES;
}

#pragma mark -SinaWeiboDelegate

// 1.授权成功之后调用的协议方法
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    
//    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    // 需要保存的认证信息
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error {
    
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo {
    
}




@end
