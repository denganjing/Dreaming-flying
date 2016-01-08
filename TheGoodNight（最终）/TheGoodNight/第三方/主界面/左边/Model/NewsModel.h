//
//  NewsModel.h
//  TheGoodNight
//
//  Created by imac on 15/10/29.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *body;

@end
