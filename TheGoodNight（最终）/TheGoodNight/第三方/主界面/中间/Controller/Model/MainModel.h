//
//  MainModel.h
//  TheGoodNight
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface MainModel : BaseModel
//营业时间
@property (nonatomic, copy) NSString *timeDesc;
//主标题
@property (nonatomic, copy) NSString *title;
//图片名
@property (nonatomic, copy) NSString *frontCoverImageList;
//距离
@property (nonatomic,strong) NSNumber*distance;
//价格
@property (nonatomic, copy) NSString *price;
//小标题
@property (nonatomic, copy) NSString *poi;
//收藏数
@property (nonatomic, strong) NSNumber *collectedNum;
//游玩类型（运动，聚会。。）
@property (nonatomic, copy) NSString *category;


@end
