//
//  GroundCell.m
//  TheGoodNight
//
//  Created by imac on 15/10/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "GroundCell.h"


@implementation GroundCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self =[super initWithStyle:style reuseIdentifier:
         reuseIdentifier];
    if (self) {
//做控件的初始化
 self.backgroundColor =[UIColor clearColor];

//创建单元格的视图
//1.初始化用户的头像
_avatar=[UIButton buttonWithType:UIButtonTypeCustom];
_avatar.frame =CGRectMake(20, 10, 30, 30);
//2.1初始化圆角
  _avatar.layer.cornerRadius = 15.0f;
 _avatar.layer.masksToBounds = YES;
  [self.contentView addSubview:_avatar];
        
//3.初始化昵称
_nickNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(_avatar.right+10, 15, 100, 30)];
_nickNameLabel.textColor =[UIColor blackColor];
_nickNameLabel.font =[UIFont boldSystemFontOfSize:14];
[self.contentView addSubview:_nickNameLabel];

//初始化时间控件
_timelabel =[[UILabel alloc]initWithFrame:CGRectMake(_nickNameLabel.right +5, 15, 100, 30)];
_timelabel.font =[UIFont systemFontOfSize:12];
_timelabel.textColor = [UIColor blackColor];
_timelabel.font = [UIFont systemFontOfSize:12.0];
[self.contentView addSubview:_timelabel];
        
//创建内容视图
_contents =[[UILabel alloc]initWithFrame:CGRectZero];
//自适应换行
_contents.numberOfLines =0;
_contents.font =[UIFont systemFontOfSize:13];
[self.contentView addSubview:_contents];
        
////创建评论按钮
//_critiButton =[[UIButton alloc]initWithFrame:CGRectMake(_contents.bottom,250 , 50, 50)];
//[self.contentView addSubview:_critiButton];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureWithModel:(BaseModel *)model
{

    if ([model isMemberOfClass:[GroundModel class]]) {
        GroundModel *gModel = (GroundModel *)model;
        _timelabel.text = gModel.time;
        _contents.text =gModel.contents;
        [_avatar sd_setImageWithURL:[NSURL URLWithString:gModel.avatar]forState:UIControlStateNormal];

      NSInteger HEIGHT =  [WXLabel getAttributedStringHeightWithString:  gModel.contents WidthValue:KScreenWidth-40 delegate:nil font:[UIFont systemFontOfSize:13.0F]];
        _contents.frame = CGRectMake(20, _avatar.bottom + 5, KScreenWidth-40, HEIGHT);
        _nickNameLabel.text = gModel.nickname;
            }
   }
@end
