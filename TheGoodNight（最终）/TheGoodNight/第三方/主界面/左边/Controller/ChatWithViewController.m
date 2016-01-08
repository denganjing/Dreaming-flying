//
//  ChatWithViewController.m
//  TheGoodNight
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ChatWithViewController.h"
#import "ChatCellHeight.h"
#import "chatCell.h"
#import  "ChatModel.h"

static NSString *cell1 =@"cell";
@interface ChatWithViewController ()


@property (strong, nonatomic) UITableView *Tableview;
@property (strong, nonatomic)  UITextField *textFeild;
@property (strong, nonatomic) UIView *inputView;



//数据模型
@property(nonatomic,strong)NSMutableArray  *datachatArr;
@end

@implementation ChatWithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatData];
    [self _loadData];
    // 3.监听键盘的弹出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
}
//界面的显示
-(void)_creatData{
    UINavigationBar *navBar =[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 49)];
    navBar.backgroundColor=[UIColor brownColor];
     [self.view addSubview:navBar];
    
    UILabel *lable =[[UILabel alloc]
    initWithFrame:CGRectMake(160, 10, 100, 36)];
    lable.text =@"小Q助理";
    [navBar addSubview:lable];
    
    UIButton *backButton =[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backbuttonaction) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:backButton];
   
    
    _Tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 49, KScreenWidth, KScreenHeight-60)style:UITableViewStylePlain];
    _Tableview.delegate =self;
    _Tableview.dataSource = self;
    //tableview 的分割线
    _Tableview.separatorStyle =NO;
    [self.view addSubview:_Tableview];
    
    _inputView=[[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-60, KScreenWidth, 60)];
    _inputView.backgroundColor =[UIColor brownColor];
    _inputView.userInteractionEnabled =YES;
    [self.view addSubview:_inputView];
    
   _textFeild=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, KScreenWidth -150, 40)];
     _textFeild.placeholder =@"快来告诉我，你的疑问吧";
    _textFeild.font =[UIFont systemFontOfSize:12];
    [_textFeild setBorderStyle:UITextBorderStyleRoundedRect];
    _textFeild.delegate = self;
    [_inputView addSubview:  _textFeild];
    
    
    UIButton *button2 =[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth -130, 5, 44, 50)];
    [button2 setTitle:@"删除" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:button2];
    
    
    UIButton *button1 =[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth -75, 5, 44, 50)];
     [button1 setTitle:@"选中" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:button1];

}

//返回按钮
-(void)backbuttonaction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) _loadData{
    
    
     NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
    NSArray *mesArray =[NSArray arrayWithContentsOfFile:path];
    self.datachatArr =[NSMutableArray arrayWithCapacity:mesArray.count];
    // 数组要初始化才能使用
    for (NSDictionary *dic in mesArray) {
        ChatModel *model = [[ChatModel alloc] init];
        
        model.content = dic[@"content"];
        model.isSelf = [dic[@"self"] boolValue];
        model.icon = dic[@"icon"];
        model.time = dic[@"time"];
        
        [_datachatArr addObject:model ];
    }

    

}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datachatArr.count;
   
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    chatCell *cell =[tableView dequeueReusableCellWithIdentifier:cell1];
    if (cell == nil) {
        cell =[[chatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
       //  去除选中效果的一种方式
        UIView *bgView = [[UIView alloc] initWithFrame:cell.bounds];
        bgView.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = bgView;
    }
    cell.model =_datachatArr[indexPath.row];
    return cell;
}
#pragma mark - TableView Delegate
// 指定每一行单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatModel *model =[_datachatArr objectAtIndex:indexPath.row];
    CGRect rect =[ChatCellHeight computeStringFrameWithContent:model.content];
    // 获取字符串的高度
    CGFloat height = rect.size.height;
    
    return height + 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      // 收起键盘
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        _Tableview.transform =CGAffineTransformIdentity;
        _inputView.transform =CGAffineTransformIdentity;
    }];
}

// 启动编辑模式
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.从数据源里面删除
        [_datachatArr removeObjectAtIndex:indexPath.row];
        
        // 2.刷新表视图
        [_Tableview reloadData];
    }
}

// 编辑模式(移动单元格)
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [_datachatArr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

#pragma mark - Action　Method
- (void)EditButton:(UIButton *)editbutton {
    // 设置编辑模式，单元格是否可以多选
    _Tableview.allowsMultipleSelectionDuringEditing = YES;
    _Tableview.allowsMultipleSelection = YES;
    
    // 设置表视图处于编辑模式
    [_Tableview setEditing:YES animated:YES];

    
}
- (void)sendButton:(UIButton*)sendbutton {
    
    NSArray *paths =[self.Tableview indexPathsForSelectedRows];
    // 找到删除的对象
    NSMutableArray *deleteArr =[NSMutableArray arrayWithCapacity:paths.count];
    for (NSIndexPath *indexpath in paths) {
        [deleteArr addObject:_datachatArr[indexpath.row]];
    }
    // 将数据源删除
    [_datachatArr removeObjectsInArray:deleteArr];
    
    // 再删除呈现的单元格
    [_Tableview deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
    
    // 关闭表视图的编辑模式
    [_Tableview setEditing:NO animated:YES];
    
    // 设置编辑模式状态，单元格是否可以多选
  _Tableview.allowsMultipleSelection = NO;
    _Tableview.allowsMultipleSelectionDuringEditing = NO;

}

#pragma mark - TextField Notification Action
// 监听到键盘弹出，调用的方法
- (void)showKeyBoard:(NSNotification *)notification
{
    // 通知对象会带一个字典，userInfo。里面会封装发送通知时，附带的一些信息
    // 把结构体封装成了对象
    NSValue *rectValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardFrame = [rectValue CGRectValue];
    
    // 取得键盘的高度
    CGFloat height = keyBoardFrame.size.height;
    
    // 设置tableview 和 inputView 跟随键盘高度变化
    _Tableview.transform = CGAffineTransformMakeTranslation(0, -height);
    _inputView.transform = CGAffineTransformMakeTranslation(0, -height);
}

#pragma mark - TextFeild Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}

// 点击return键
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 1.取得textField里面的text
    NSString *content = textField.text;
    
    //2.创建模型
    ChatModel *model =[[ChatModel alloc]init];
    model.content = content;
    model.isSelf = YES;
    model.icon = @"icon01.jpg";
    model.time = @"";
    // 3.把Model加入到数据员数组
    [_datachatArr addObject:model];
    
    // 4.刷新表视图
    [_Tableview reloadData];
    
    // 5.tableView滚动最后一个单元格
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_datachatArr.count - 1 inSection:0];
    [_Tableview scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
    return YES;

}

#pragma mark - View Controller --  Life Cycle
// 视图已经渲染
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //tableView 滚动到最后一个单元格
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_datachatArr.count - 1 inSection:0];
    [_Tableview scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
