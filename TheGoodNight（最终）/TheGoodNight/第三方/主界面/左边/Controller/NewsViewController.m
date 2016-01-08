//
//  NewsViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsViewCell.h"
#import "NewsModel.h"
#import "WebViewController.h"
static NSString *newidentifier =@"cell";

@interface NewsViewController (){
    NSMutableArray *_Newmodels;
    NSArray *_ImageArr;
    NSArray *_TitleArr;
    NSInteger direction;
    NSTimer *_timer;

}

//滑动视图需要的
@property(nonatomic,strong)UIImageView *selectedView;
@property(nonatomic,strong)UIPageControl *pageCtrol;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  _ImageArr =@[@"splash1",@"splash2",@"splash3",@"splash4",@"splash5"];
    _TitleArr =@[@"简约国际时尚范",@"军事天地",@"起雾非凡",@"油画的天地",@"非凡的人生",@"浴火重生"];
    
    [self creatAnylazeJson];
    [self createNav];
    [self createTable];
   
  
}
-(void)creatAnylazeJson{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"news" ofType:@"json"];
    NSData *data =[NSData dataWithContentsOfFile:path];
NSDictionary *newDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     //获取数组
   NSArray  *newArr=newDic[@"news"];
    _Newmodels =[NSMutableArray arrayWithCapacity:newArr.count];
     //遍历数组，构造模型对象
    for (NSDictionary *newContentDic in newArr) {
        //将字典构造成模型

        NewsModel *model =[[NewsModel alloc]initWithJSONDictionaray:newContentDic];
        //存储数据源数据
        [_Newmodels addObject:model];
    }

}
-(void)createNav{
    // 设置标题
    UILabel *titleText =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2 -10, 10, 100, 50)];
    [titleText setText:@"最国际"];
    self.navigationItem.titleView =titleText;
    [self.view addSubview:titleText];
    
    //返回按钮
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 10, 64, 44)];
    [leftbutton setImage:[UIImage imageNamed:@"iphone_setting_nav_back"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(Leftback) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    [self.view addSubview:leftbutton];


}
-(void)createTable{
    _Newtableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight -64) style:UITableViewStylePlain];
    _Newtableview.delegate = self;
    _Newtableview.dataSource = self;
    [self.view addSubview:_Newtableview];
    _Newtableview.separatorStyle =YES;
    [_Newtableview registerClass:[NewsViewCell class] forCellReuseIdentifier:newidentifier];
    //把scrollView设置为头视图
    //使用懒加载
    _Newtableview.tableHeaderView =[self head];
    
}
-(void)Leftback{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _Newmodels.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NewsViewCell *cell =[tableView dequeueReusableCellWithIdentifier:newidentifier forIndexPath:indexPath];
    
    
    [cell configureCellWithModel:_Newmodels[indexPath.row]];
    
     return  cell;
}

//计算单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 300;
}
//赖加载UIView
-(UIView *)head
{
    UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 270) ];
[myview addSubview:self.scrollView];

[ myview addSubview:self.pageCtrol];
    return myview;
}

-(UIPageControl *)pageCtrol
{
    if (!_pageCtrol) {
  
    // 页码控件
    _pageCtrol = [[UIPageControl alloc] initWithFrame:CGRectMake(KScreenWidth/2 -20, 215, 50, 20)];
    _pageCtrol.backgroundColor = [UIColor clearColor];
    _pageCtrol.numberOfPages = 5;  // 页码数
    _pageCtrol.currentPage = 0;   // 当前页
    _pageCtrol.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 监听page control 事件
    [_pageCtrol addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageCtrol;
}


-(UIScrollView*)scrollView{
    if(!_scrollView){
   
   
    //创建滑动视图
_scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight/2 -100)];
_scrollView.delegate = self;
_scrollView.contentSize = CGSizeMake(KScreenWidth* 5, 0);
//是否整个翻动
_scrollView.pagingEnabled = YES;
_scrollView.showsHorizontalScrollIndicator = NO;

    
//创建子视图
for (int i=0; i<=_ImageArr.count; i++) {
NSString *imgName=[NSString stringWithFormat:@"splash%d.jpg",i];
UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(_scrollView.width*(i-1), 0, _scrollView.width, KScreenHeight/2 -80)];
imageView.image =[UIImage imageNamed:imgName];
[_scrollView addSubview:imageView];
    
    UIView *myview =[[UIView alloc]initWithFrame:CGRectMake(_scrollView.width*(i-1), _scrollView.height -44, _scrollView.width, 20)];
    myview.backgroundColor =[UIColor redColor];
    UILabel *titleLable =[[UILabel alloc]initWithFrame:CGRectMake(myview.width/2-10  ,0, myview.width,20)];
    titleLable.text = [_TitleArr objectAtIndex:i];
    [myview addSubview:titleLable];
  [_scrollView addSubview:myview];
    
 
    

   }
   
_timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
   //加到NSRunLoop，防止内存泄漏
[[NSRunLoop currentRunLoop]addTimer:_timer forMode:UITrackingRunLoopMode];

    }
    return _scrollView;
}

- (void)pageAction:(UIPageControl *)sender {
    CGFloat offSetX = sender.currentPage * KScreenWidth;
    // 滑动到指定位置
    [_scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //开始滑动时，定时器停止
    [_timer invalidate];
}
// 滑动视图停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 根据偏移量计算 当前偏移到了第几页
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    _pageCtrol.currentPage = page;
    if (page == 4) {
        _pageCtrol.currentPage = 0;
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
//视图停止滑动定时器开启
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    
}

-(void)timeAction:(NSTimer *)timer{
if (_scrollView.contentOffset.x ==KScreenWidth*(_ImageArr.count -1)) {
    direction = -1;
 float offSetX =_scrollView.contentOffset.x +KScreenWidth*direction;
    [_scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    }
if (_scrollView.contentOffset.x ==0) {
    direction =1;
    float offSetX =_scrollView.contentOffset.x +KScreenWidth*direction;
    [_scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    }
    float  offSetX =_scrollView.contentOffset.x +KScreenWidth*direction;
    [_scrollView setContentOffset:CGPointMake(offSetX, 0)animated:YES];
  //跟换page页码
    NSInteger page = offSetX / _scrollView.width;
    
    _pageCtrol.currentPage = page;
}



//跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WebViewController *webView =[[WebViewController alloc]init];
        webView.webstring = [_Newmodels[indexPath.row]body ];
    [self presentViewController:webView animated:YES completion:nil];
    }
}



@end
