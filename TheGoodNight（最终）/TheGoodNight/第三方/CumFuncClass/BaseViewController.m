//
//  BaseViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/31.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    UIView *_tipView;
    MBProgressHUD *_hud;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark 用hud自定义菊花
-(void)showHud:(NSString *)title{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    //菊花旁边的文本
    _hud.labelText = title;//主标题
    _hud.detailsLabelText = title;//子标题
    _hud.detailsLabelFont = [UIFont systemFontOfSize:8.0];
    
    //给菊花后面的视图加一个阴影
    _hud.dimBackground = YES;
    [_hud show:YES];
}

-(void)hideHud:(NSString *)title{
    if (title.length == 0) {
        [_hud hide:YES];
    }
    //如果消失之前还要给出相应的字体提示的话
    else{
        //微信的效果，消失之前出现 _hud.labelText 也出现一个对勾（一张图片）
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.labelText = title;
        [_hud hide:YES afterDelay:2.5];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
