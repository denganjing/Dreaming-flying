//
//  CenterViewController.m
//  the  good night
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//
#import "CenterViewController.h"
#import "RightViewController.h"
#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MainModel.h"
#import "MainViewCell.h"

@interface CenterViewController (){
           NSURL *_url ;
           NSData *_data ;
           NSString *_titleString;
           int i; //刷新不同的组数
}

@property (nonatomic, strong) NSMutableArray *dataArray;


@end
static NSString *identifier =@"identifier";
@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //只初始化一次,显示的组数，而且加到dataarray
  self.dataArray =[NSMutableArray arrayWithCapacity:5];
  
    self.view.backgroundColor =[UIColor whiteColor];
    [self createnav];
    //设置网络加载的时候tableview是线出现的
    [self createTable];
    [self _requestData];

    
  //设置网络加载
__weak CenterViewController *weakCenter =self;
[_tableview addLegendHeaderWithRefreshingBlock:^{
//移除所有数据
[weakCenter.dataArray removeAllObjects];
    [_tableview reloadData];
  NSLog(@"下拉刷新了");
    [weakCenter performSelector:@selector(stopAction) withObject:nil afterDelay:1];
    [self _requestData];
    
}];
 
//就做上拉加载
[_tableview addLegendFooterWithRefreshingBlock:^{
    [weakCenter _loadMoreData];
    [weakCenter performSelector:@selector(UpstopAction) withObject:nil afterDelay:1];
}];
}
//下拉停止
-(void)stopAction{
    //下拉后自动返回
    [_tableview.header endRefreshing];

}

//上拉停止
-(void)UpstopAction{
    [_tableview.footer endRefreshing];
}

-(void)createnav{
//创建一个导航栏
UINavigationBar *navbar =[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
navbar.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_gallery_title_label"]];
//创建一个导航栏集合
    UINavigationItem *navItem =[[UINavigationItem alloc]initWithTitle:nil];
//在这个集合item添加标题，按钮
//style：设置按钮的风格，一共有三种选择
//action：@selector：设置按钮的点击事件
//创建一个左边按钮
    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"follow"]style:UIBarButtonItemStyleDone target:self action:@selector(leftButtonAction)];
    
//创建一个右边按钮
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"infoCenter_icon_favorite"] style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction)];
    
//设置导航栏的内容
    

      _titleString =@"the Good Life";
    if (_index) {
         _titleString =_TString;
        }
    
     [navItem setTitle:_titleString];
    
//把导航栏集合添加到导航栏，设置动画关闭
    [navbar pushNavigationItem:navItem animated:NO];
//把左右二个按钮添加到导航栏集合
    [navItem setLeftBarButtonItem:leftButton];
    [navItem setRightBarButtonItem:rightButton];
//将标题栏的内容全部添加到主视图
    [self.view addSubview:navbar];

}

-(void)leftButtonAction{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightButtonAction{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    //回去模态视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)_requestData{

if (_index) {
    
        _path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%ld",_index+1] ofType:@"json"];
        _data =[NSData dataWithContentsOfFile:_path];
    
    NSDictionary *resultDic =[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    //获取SUbject数组
    NSArray *resultArr =resultDic[@"result"];
    
    
    //遍历数组，构造模型对象
    for (NSDictionary *contentDic  in resultArr) {
        
        
        //将字典构造成模型
        MainModel *model =[[MainModel alloc]initWithJSONDictionaray:contentDic];
        //存储数据源数据
        [self.dataArray addObject:model];
    }

    }
    
if (!_index) {
        [self showHud:@"拼命加载数据中"];
AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
manager.requestSerializer =[AFHTTPRequestSerializer serializer];
manager.responseSerializer =[AFHTTPResponseSerializer serializer];
[manager GET:@"http://api.lanrenzhoumo.com/main/recommend/index?session_id=000043b8fbadcf43d24e52480542ff8cdb59e0&v=3&page=2&lon=114.44208&lat=30.493576" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *resultDic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //获取SUbject数组
NSArray *resultArr =resultDic[@"result"];
    //遍历数组，构造模型对象
for (NSDictionary *contentDic  in resultArr) {
        //将字典构造成模型
        MainModel *model =[[MainModel alloc]initWithJSONDictionaray:contentDic];
        //存储数据源数据
        [self.dataArray addObject:model];
    //显示分割线
    _tableview.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    }
         [self hideHud:@"已经加载完成"];
    [_tableview reloadData];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"错误%@",error);
}];
    
}
        
    
}

-(void)_loadMoreData{
     [self showHud:@"拼命加载数据中"];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"http://api.lanrenzhoumo.com/main/recommend/index?session_id=000043b8fbadcf43d24e52480542ff8cdb59e0&v=3&page=%d&lon=114.44208&lat=30.493576",i ]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *resultDic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //获取SUbject数组
        NSArray *resultArr =resultDic[@"result"];
       
        //遍历数组，构造模型对象
        for (NSDictionary *contentDic  in resultArr) {
            //将字典构造成模型
            MainModel *model =[[MainModel alloc]initWithJSONDictionaray:contentDic];
            //存储数据源数据
            [self.dataArray addObject:model];
        }
        [self hideHud:@"已经加载完成"];
        [_tableview reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误%@",error);
    }];
    
      i++;
}
-(void)createTable{
   
    _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight -64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    //数据加载之前把分割线隐藏
    _tableview.separatorStyle =UITableViewCellAccessoryNone;
    _tableview.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_columnList_bg"]];
    [self.view addSubview:_tableview];
    
    //注册单元格
[_tableview registerNib:[UINib nibWithNibName:@"MainViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
  // 指定表视图派遣带有复用标识的单元格
 MainViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
[cell configureCellWithModel:self.dataArray[indexPath.row]];
    cell.userInteractionEnabled =YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
