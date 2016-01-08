//
//  MainModel.m
//  TheGoodNight
//
//  Created by imac on 15/10/26.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel
-(instancetype)initWithJSONDictionaray:(NSDictionary *)Dic{
    self =[super init];
    if (self) {
        self.timeDesc =Dic[@"time_info"];
        self.title =Dic[@"title"];
        self.frontCoverImageList =Dic[@"front_cover_image_list"];
        self.price = Dic[@"price_info"];
        self.distance =Dic[@"distance"];
        self.poi =Dic[@"poi"];
        self.collectedNum =Dic[@"collected_num"];
        self.category =Dic[@"category"];
   self.frontCoverImageList=[Dic[@"front_cover_image_list"]firstObject];
           }
    return self;
}


@end
