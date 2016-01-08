//
//  NewsModel.m
//  TheGoodNight
//
//  Created by imac on 15/10/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
-(instancetype)initWithJSONDictionaray:(NSDictionary *)Dic{
    if (self) {
        self.image =Dic[@"image"];
        self.title =Dic[@"title"];
        self.body =Dic[@"body"];
    }
    return self;
}
@end
