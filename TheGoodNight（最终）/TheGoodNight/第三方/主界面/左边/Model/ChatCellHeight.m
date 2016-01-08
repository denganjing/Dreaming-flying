//
//  ChatCellHeight.m
//  TheGoodNight
//
//  Created by imac on 15/10/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ChatCellHeight.h"

@implementation ChatCellHeight
//传进来一个字符串，根据配置计算文字的区域大小
+(CGRect)computeStringFrameWithContent:(NSString *)content{
    UIFont *labelFont =[UIFont systemFontOfSize:16];
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    NSDictionary *attrDict =[NSDictionary dictionaryWithObjectsAndKeys:labelFont, NSFontAttributeName,paragraphStyle,NSFontAttributeName,nil];
    CGRect rect =[content boundingRectWithSize:CGSizeMake(200, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil];
    return rect;
}
@end
