//
//  NewsViewCell.h
//  TheGoodNight
//
//  Created by imac on 15/10/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsViewCell : UITableViewCell{
//背景视图
UIImageView *_newimageview;
//标题
 UILabel *_Newtitle;
//网页链接
UILabel *_Newbody;
}

-(void)configureCellWithModel:(NewsModel*)model;
@end
