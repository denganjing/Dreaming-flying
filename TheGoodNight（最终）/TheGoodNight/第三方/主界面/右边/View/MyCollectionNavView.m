//
//  MyCollectionNavView.m
//  TheGoodNight
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MyCollectionNavView.h"
#import "MyCollectionDetailView.h"
@interface MyCollectionNavView (){
    UITableView *_tableview;
    NSArray *_dataArr;
    NSArray *_htmlArr;
}

@end

@implementation MyCollectionNavView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateColllectionnav];
    [self CreteColllectionTable];
}

-(void)CreateColllectionnav{
    // 设置标题
    UILabel *titleText =[[UILabel alloc]initWithFrame:CGRectMake(170, 10, 50, 50)];
    [titleText setText:@"收藏"];
    self.navigationItem.titleView =titleText;
    [self.view addSubview:titleText];
    
    //返回按钮
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(20, 13, 44, 44)];
    [leftbutton setTitle:@"返回" forState:UIControlStateNormal];
    [leftbutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(Leftback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    [self.view addSubview:leftbutton];
    
    //收藏
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(310, 13, 44, 44)];
    [rightbutton setImage:[UIImage imageNamed:@"add_favor_already_clicked"] forState:UIControlStateNormal];
    [rightbutton setImage:[UIImage imageNamed:@"add_favor_already_normal"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    [self.view addSubview:rightbutton];

}

-(void)Leftback{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CreteColllectionTable{
    _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight -64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview: _tableview];
    
    _dataArr =@[@"法国最经典帆船",@"Javuar XE 豹风来袭",@"兰博基尼梦幻之作",@"福特MUSTANG马到成功"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
if (indexPath.section ==0 && indexPath.row <4) {
    MyCollectionDetailView *detail = [[MyCollectionDetailView alloc]init];
        detail.index = indexPath.row+1;
       [self presentViewController:detail animated:NO completion:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
