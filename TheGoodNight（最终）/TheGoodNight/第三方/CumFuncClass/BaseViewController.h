//
//  BaseViewController.h
//  TheGoodNight
//
//  Created by imac on 15/10/31.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController
//用mb显示菊花
-(void)showHud:(NSString *)title;

//用mb隐藏菊花
-(void)hideHud:(NSString *)title;
@end
