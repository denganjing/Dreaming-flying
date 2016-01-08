//
//  MainViewCell.h
//  TheGoodNight
//
//  Created by imac on 15/10/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainModel;
@interface MainViewCell : UITableViewCell

-(void)configureCellWithModel:(MainModel*)model;
@end
