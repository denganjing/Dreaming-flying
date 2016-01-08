//
//  RightViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RightViewController.h"
#import "SinaLoginViewController.h"
#import "GroundViewController.h"
#import "MyCollectionNavView.h"
@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}
@property(nonatomic,strong)NSArray *titleName;
@property(nonatomic,strong)NSArray *imageName;
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _requrstdate];
    [self _TopLogin];
    [self _createTable];
    
}
-(void) _requrstdate{
    self.titleName =@[@[@"Good Life",@"我的首页",@"浏览发现",@"通知中心"],@[@"我的收藏"]];
   // self.imageName =@[@[@"infoCenter_icon_card",@"dot",@"dot",@"dot"],@[@"infoCenter_icon_favorite"]];

}

-(void)_TopLogin{
    //图片
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-80)/2-60, 20, (KScreenWidth-80)/2-60, 90)];
    imageview.image =[UIImage imageNamed:@"avatar_placeholder"];
    [self.view addSubview:imageview];
   
    //按钮
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth-80)/2-80, 120, (KScreenWidth-80)/2, 32)];
    [button setImage:[UIImage imageNamed:@"primary_bttn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(button.width/3+5, 10, button.width/2, button.height-20)];
    lable.text =@"登录";
    lable.textColor =[UIColor colorWithWhite:1 alpha:0.9];
    [button addSubview:lable];
}

//登录界面
-(void)ButtonAction:(UIButton*)button{
    SinaLoginViewController *sinaLogin =[[SinaLoginViewController alloc]init];
    [self presentViewController:sinaLogin   animated:NO completion:nil];
}

-(void)_createTable{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, KScreenWidth, KScreenHeight-200) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
 //设置分割线的样式
    _tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor =[UIColor grayColor];

}
#pragma mark - DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  _titleName.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *secondarr =_titleName[section];
    return secondarr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
   //组索引
    NSInteger section =indexPath.section;
   //行索引
    NSInteger row =indexPath.row;
    //解析数据
   
    //文本
    NSArray *subArray= self.titleName[section];
    NSString *title =subArray[row];
    cell.textLabel.text =title;
    
    //图片
    NSArray *imageArr = self.imageName[section];
    NSString *image =imageArr[row];
    cell.imageView.image=[UIImage imageNamed:image];
    return cell;
    
  }


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //浏览发现
    if (indexPath.section == 0 && indexPath.row ==2 ) {
        GroundViewController *groud =[[GroundViewController alloc]init];
        [self presentViewController:groud animated:YES completion:nil];
    }
    
    
 //我的收藏
    if (indexPath.section == 1) {
MyCollectionNavView *mycollection =[[MyCollectionNavView alloc]init];
[self presentViewController:mycollection animated:YES completion:nil];
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
