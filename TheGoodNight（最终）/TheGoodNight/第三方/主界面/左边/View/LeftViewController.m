//
//  LeftViewController.m
//  the  good night
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LeftViewController.h"
#import "ChatWithViewController.h"
#import "NewsViewController.h"
#import "SettingViewController.h"
@interface LeftViewController (){
    UITableView  *_tableview;
    NSArray *_images;
    NSArray *_arr;
    UILabel *_lable;
    NSArray *_Colors;
    //城市列表
    UIView *_cityview;
    //关于按钮
    UIImageView *_AboutimageView;
}

@end
@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTable];
     //数据
    _arr =@[@"最好玩",@"最文艺",@"最疯狂",@"最旅行",@"最国际",@"小助理",@"设置",@"关于"];
   
  _images =@[@"menu_landscape_highlighted",@"menu_landscape_highlighted-2",@"menu_landscape_highlighted-4",@"menu_landscape_highlighted-8",@"menu_landscape_highlighted-3",@"menu_landscape_highlighted-1",@"menu_landscape_highlighted-7",@"menu_landscape_highlighted-6"];
}


-(void)createTable{
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth -80,300)];
    imageview.image =[UIImage imageNamed:@"iphone_first_hint"];
    imageview.userInteractionEnabled =YES;
    [self.view addSubview:imageview];
    
    _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 200, KScreenWidth, KScreenHeight-300) style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

   

    NSString *image =_images[indexPath.row];
   cell.imageView.image=[UIImage imageNamed:image];
 
    cell.textLabel.text =_arr[indexPath.row];
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////让cell跳转到中间页，在利用每一行cell 传递数据，刷新界面
if (indexPath.section ==0 && indexPath.row <4) {
    
    CenterViewController  *center =[[CenterViewController alloc]init];
    
    center.index = indexPath.row + 1;
    center.TString= _arr[indexPath.row] ;
   [self presentViewController:center animated:NO completion:nil];
}
 
    
//加载新闻页
if (indexPath.row ==4) {

    NewsViewController *newview =[[NewsViewController alloc]init];
    [self presentViewController:newview  animated:NO completion:nil];
    }
//小助理
 if (indexPath.row ==5) {
ChatWithViewController *chatview =[[ChatWithViewController alloc]init];
[self presentViewController:chatview animated:NO completion:nil];
    }
//设置
    if (indexPath.row == 6) {
        SettingViewController *setview =[[SettingViewController alloc]init];
        [self presentViewController:setview animated:NO completion:nil];
    }
//关于
    if (indexPath.row ==7) {
    _cityview =[[UIView alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth, KScreenHeight)];
    _cityview.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_cityview];
    _AboutimageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ipad_info_bg"]];
    _AboutimageView.frame =CGRectMake(0, 0, KScreenWidth-60, KScreenHeight-70);
    _AboutimageView.userInteractionEnabled =YES;
    [_cityview addSubview:_AboutimageView];
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2+50, 5, 33, 33)];
    [button setImage:[UIImage imageNamed:@"iphone_close"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(AboutButtonAction2) forControlEvents:UIControlEventTouchUpInside];
    button.userInteractionEnabled =YES;
    [_cityview addSubview:button];
       }

}

-(void)AboutButtonAction2{
    [ _cityview setHidden:YES ];
}

@end
