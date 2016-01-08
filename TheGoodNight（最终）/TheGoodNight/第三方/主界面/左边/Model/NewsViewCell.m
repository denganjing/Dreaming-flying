//
//  NewsViewCell.m
//  TheGoodNight
//
//  Created by imac on 15/10/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "NewsViewCell.h"
#import "NewsModel.h"

@implementation NewsViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 self.backgroundColor =[UIColor clearColor];
 //创建控件对应的位置
// 图片
        _newimageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"splash3"]];
        _newimageview.frame =CGRectMake(10, 10, KScreenWidth-20, 250);
        [self.contentView addSubview:_newimageview];
//标题
    _Newtitle =[[UILabel alloc]initWithFrame:CGRectMake(10, 270, KScreenWidth-10, 20)];
    _Newtitle.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:_Newtitle];
        
////链接
//    _Newbody =[[UILabel alloc]initWithFrame:CGRectMake(10, 190, KScreenWidth -100, 10)];
//    _Newbody.userInteractionEnabled =YES;
//    [self.contentView addSubview:_Newbody];
        
    }
    return self;
}


-(void)configureCellWithModel:(NewsModel *)model{
    _Newtitle.text =model.title;
    _Newbody.text =model.body;
    [_newimageview sd_setImageWithURL:[NSURL URLWithString:model.image]];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
