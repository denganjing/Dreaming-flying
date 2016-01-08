//
//  GroundModel.h
//  TheGoodNight
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface GroundModel : BaseModel
//用户信息
@property(nonatomic,strong)NSString *uid;
//用户名
@property(nonatomic,strong)NSString *nickname;
//用户头像
@property(nonatomic,strong)NSString *avatar;
//当前时间
@property(nonatomic,strong)NSString *time;
//文本
@property(nonatomic,strong)NSString *contents;


+(NSArray *)requestModelsWithJSONDictionaray:(NSDictionary *)JSONDic;
@end
