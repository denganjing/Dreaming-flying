//
//  CenterViewController.h
//  the  good night
//
//  Created by imac on 15/10/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"


@interface CenterViewController :BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,copy)NSString *path;

@property (nonatomic,assign) NSInteger index;

@property(nonatomic,copy)NSString *TString;
@end
