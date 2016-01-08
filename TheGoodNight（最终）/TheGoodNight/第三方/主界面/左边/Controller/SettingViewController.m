//
//  SettingViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/30.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SettingViewController.h"
#import "UIImageView+WebCache.h"
@interface SettingViewController (){
    
      NSArray *_imagarr;
      NSArray *_title;
}

@property(strong,nonatomic)UITableView *tableView;
@property (assign, nonatomic) CGFloat cacheFileSize;

@end
static NSString *cell1 =@"cell1";
@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _crateDate];
    [self _craTable];
    [self _crateNav];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self _computeCacheFileSize];
}


-(void)_crateDate{
    _imagarr= @[@"ic_feedback",@"ic_trash",@"ic_heart",@"ic_update",@"ic_tel",@"ic_logout"];
    _title = @[@"用户反馈",@"清除缓存",@"给我们一个评价",@"检查更新",@"联系我们",@"退出登录"];

}

-(void)_crateNav{
    
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth, 64)];
    topView.image = [UIImage imageNamed:@"frame_bottom"];
    topView.userInteractionEnabled =YES;
    [self.view addSubview:topView];
  
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 5, 44, 44);
    [backButton setImage:[UIImage imageNamed:@"ic_nav_left"] forState:UIControlStateNormal];
    backButton.userInteractionEnabled =YES;
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
   
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-200/2, 10, 200, 30)];
    titleLable.text = @"设置";
    titleLable.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLable];
}

-(void)backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
   
}
-(void)_craTable{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 44, KScreenWidth-15, KScreenHeight-50) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:_tableView];
    
    
}

-(void)_computeCacheFileSize{
    NSString *sandBoxPath =NSHomeDirectory();
    
    //所有沙盒目录都是一样
NSString *cachesPath =[sandBoxPath stringByAppendingPathComponent:@"Library/Caches/com.hackemist.SDWebImageCache.default"];
    // 文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取制定目录下的所有的文件名
    NSArray *fileNames =[fileManager subpathsOfDirectoryAtPath:cachesPath error:nil];
    unsigned long long sum =0;
    // 获取指定文件的属性
    for (NSString *fileName in fileNames) {
        // 拼接文件的具体路径
        NSString *filePath =[cachesPath stringByAppendingPathComponent:fileName];
        //获取制定位置的文件属性
        NSDictionary *attributesDic =[fileManager attributesOfItemAtPath:filePath error:nil];
        unsigned long long size =[attributesDic fileSize];
        sum += size;
    }
    self.cacheFileSize = sum /1024.0/1024.0;
    //刷新表视图
    [_tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imagarr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell1 forIndexPath:indexPath];
    cell.backgroundColor =[UIColor clearColor];
    cell.imageView.image =[UIImage imageNamed:_imagarr[indexPath.row]];
    cell.textLabel.text =_title[indexPath.row];
   
if (indexPath.row == 1 &&indexPath.section ==0) {
        UILabel *cachelabel =[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth -170.f, 0.f, 150.f, 50)];
        cachelabel.tag =100;
        cachelabel.font =[UIFont systemFontOfSize:15];
        cachelabel.textAlignment =NSTextAlignmentRight;
    [cell.contentView addSubview:cachelabel];
   
    }
    
    
    if (indexPath.row ==3) {
        UILabel *check = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-170, 0, 150, 50)];
        check.text = @"当前版本：V2.0.1";
         check.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:check];
     }
    
    if (indexPath.row == 4) {
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-170, 0, 150, 50)];
        phoneLabel.text = @"400-844-0900";
        phoneLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:phoneLabel];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
if (indexPath.row == 1 &&indexPath.section ==0) {
    UILabel *cacheslabel =(UILabel *)[cell.contentView viewWithTag:100];
    cacheslabel.text =[NSString stringWithFormat:@"%.1fMb",self.cacheFileSize];
    NSLog(@"%@",cacheslabel.text);
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row ==1) {
    //SD框架 清理缓存是一个移步处理
        [[SDImageCache sharedImageCache]clearDisk];
        [self performSelector:@selector(_computeCacheFileSize) withObject:nil afterDelay:0.5];
      
    }
}
@end
