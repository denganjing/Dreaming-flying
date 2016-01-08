//
//  NewsViewController.h
//  TheGoodNight
//
//  Created by imac on 15/10/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UINavigationController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>{
    UITableView *_Newtableview;
}

@end
