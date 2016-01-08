//
//  项目日志.h
//  TheGoodNight
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#ifndef __TheGoodNight________
#define __TheGoodNight________

#include <stdio.h>

#endif /* 
1.用倒入第三方框架MMDrawerController，做出抽屉的效果
2.创建中间，右边，左边的控制器（center，left，right继承UiviewController）
3.绑定按钮（要在center控制器中导入#import "UIViewController+MMDrawerController.h"，在导航栏button方法中使用 [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil] 方法）
4.导航栏与模态视图的区别：导航栏（push和pop），模态（presentView和dismiss）
5.tableview 的cell 可以全部实现点击（-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}方法）根据indexPath的section和row
6.懒加载方法（［self head］ 或者是self.head 调用get方法）
7.滑动图片的


*/
