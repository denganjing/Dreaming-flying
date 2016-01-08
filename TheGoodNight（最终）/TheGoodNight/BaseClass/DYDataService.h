//
//  DYDataService.h
//  MyMovie
//
//  Created by 邓奕 on 15/9/4.
//  Copyright (c) 2015年 文华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYDataService : NSObject

+ (id)requestDataWithJSONFileName:(NSString *)fileName;

+ (NSMutableArray *)modelArrayWithJSONFileName:(NSString *)fileName forModelClass:(Class)modelClass;

// 将存放字典的数据，直接构造成存放指定模型的数据
+ (NSMutableArray *)modelArrayWithArrayForDictionary:(NSArray *)array forModelClass:(Class)modelClass;

@end
