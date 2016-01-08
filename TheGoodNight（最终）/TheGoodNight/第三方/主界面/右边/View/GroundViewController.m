//
//  GroundViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "GroundViewController.h"
#import "GroundCell.h"
#import "GroundModel.h"
@interface GroundViewController (){
    //创建视图
    UITableView *_tableview;
    
    //模型数据
    NSArray *_models;
}

@end

@implementation GroundViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _navButton];
    [self _cratetable];
    [self _analyzeJson];
    
}

-(void)_navButton{
    // 设置标题
    UILabel *titleText =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-10, 10, 50, 50)];
    [titleText setText:@"广场"];
    self.navigationItem.titleView =titleText;
    [self.view addSubview:titleText];

    
    
    //返回按钮
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 64, 44)];
    [leftbutton setImage:[UIImage imageNamed:@"iphone_setting_nav_back"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(Leftback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    [self.view addSubview:leftbutton];
    
    //写文字
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-50, 13, 54, 44)];
    [rightbutton setImage:[UIImage imageNamed:@"nav_writeNote"] forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(writeback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    [self.view addSubview:rightbutton];
   
}
//返回的按钮
-(void)Leftback{
 [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)writeback{

}

//创建表格
-(void)_cratetable{
    
    
    _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight -64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
    //自定义cell 的标识符
    [_tableview registerClass:[GroundCell class] forCellReuseIdentifier:@"cell"];
   
    
}

//解析json数据
-(void)_analyzeJson{
    NSURL *url =[NSURL URLWithString:@"http://card.bb.bbwc.cn/vt/app32/card/api/recommendCardList/datatype/2/bottom/0"];
    NSData *data =[NSData dataWithContentsOfURL:url];
    
  //  NSString *path = [[NSBundle mainBundle] pathForResource:@"id" ofType:@"json"];
    
   // NSData *data  = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    _models = [GroundModel requestModelsWithJSONDictionaray:jsonDic];


}

#pragma mark---table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  _models.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GroundCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell configureWithModel:_models[indexPath.row]];
    
    //cell.textLabel.text = @"ggvgvvg";
    return cell;
}

//计算文本高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GroundModel *model = _models[indexPath.row];
   
    CGFloat wb_height =[WXLabel getAttributedStringHeightWithString:model.contents WidthValue:KScreenWidth-40 delegate:nil font:[UIFont systemFontOfSize:13.0f]];
    float height = 70;
    //文本高度等于
    height += wb_height;
//     NSLog(@"%lf",height);
    return height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
