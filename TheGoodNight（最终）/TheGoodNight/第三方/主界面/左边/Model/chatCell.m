//
//  chatCell.m
//  TheGoodNight
//
//  Created by imac on 15/10/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "chatCell.h"
#import "ChatCellHeight.h"
#import "ChatModel.h"
@interface chatCell (){
    // 子视图
UIImageView *_userImg; // 用户头像
UIImageView *_bgImg;   // 背景
UILabel *_msgLabel;   // 消息内容
    
}
@end
@implementation chatCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createViews];
    }
    return self;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//创建子视图
-(void)_createViews{
    _userImg =[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_userImg];
    _bgImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_bgImg];
    
    _msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _msgLabel.font = [UIFont systemFontOfSize:16];
    _msgLabel.textColor = [UIColor blackColor];
    _msgLabel.numberOfLines = 0;
    [self.contentView addSubview:_msgLabel];

}

-(void)setModel:(ChatModel *)model{
    if (_model != model) {
        _model = model;
    }
//用户头像
    UIImage *userIcon =[UIImage imageNamed:_model.icon];
    _userImg.image = userIcon;

// 文本的背景气泡图片
  UIImage *img1 = [UIImage imageNamed:@"chatfrom_bg_normal"];
 UIImage *img2 = [UIImage imageNamed:@"chatto_bg_normal"];
// 判断是否是自己发送的消息（根据结果改变背景图片）
UIImage *img =_model.isSelf? img2:img1;
img =[img stretchableImageWithLeftCapWidth:img.size.width *0.5 topCapHeight:img.size.height*0.7];
    _bgImg.image =img;
//聊天内容
   _msgLabel.text =_model.content;
    [self setNeedsLayout];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect =[ChatCellHeight computeStringFrameWithContent:_msgLabel.text];
 // 区分，消息是否为好友发送
    if (_model.isSelf) {
  //是自己发的消息
        _userImg.frame = CGRectMake(KScreenWidth - 40 - 30, 10, 40, 40);
        _bgImg.frame = CGRectMake(KScreenWidth - 290, 10, 220, rect.size.height + 30);
        _msgLabel.frame = CGRectMake(KScreenWidth - 270, 20, 180, rect.size.height);
       
    }else{
        _userImg.frame = CGRectMake(30, 10, 40, 40);
        _bgImg.frame = CGRectMake(70, 10, 220, rect.size.height + 30);
        _msgLabel.frame = CGRectMake(90, 20, 180, rect.size.height);
    
    
    }

}

@end
