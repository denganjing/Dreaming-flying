//
//  GroundCell.h
//  TheGoodNight
//
//  Created by imac on 15/10/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroundModel.h"
@interface GroundCell : UITableViewCell{
 //背景视图
   UIImageView *_bgImageView;
 //头像
    UIButton *_avatar;
 //用户昵称
    UILabel *_nickNameLabel;
  //时间
    UILabel *_timelabel;
  //内容视图
    UILabel *_contents;
  //评论按钮
    UIButton *_critiButton;
    

}
-(void)configureWithModel:(BaseModel *)model;
@end
