//
//  MenuViewController.m
//  the  good night
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MenuViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "CenterViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置左右侧滑
    [self leftAndRightslider];
}

-(void)leftAndRightslider{
    //设置菜单左边的控制器
    self.leftDrawerViewController =[[LeftViewController alloc]init];
    //设置菜单右边的控制器
    self.rightDrawerViewController =[[RightViewController alloc]init];
    //设置菜单中间的控制器
    self.centerViewController =[[CenterViewController alloc]init];
    //设置手势的作用范围
    //设置左侧视图的宽
    self.maximumLeftDrawerWidth =KScreenWidth-80;
    self.maximumRightDrawerWidth = KScreenWidth-80;
    //设置开启手势
    self.openDrawerGestureModeMask =MMOpenDrawerGestureModeAll;
    //设置关闭手势
    self.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //配制动画的回调的函数
    [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block =[[MMExampleDrawerVisualStateManager sharedManager]drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
        //readme 这个事第三方给的一个固定配置动画的block
        
        //设置动画类型
        [[MMExampleDrawerVisualStateManager sharedManager]setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
        [[MMExampleDrawerVisualStateManager sharedManager]setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
        
    }];
    
 
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
