//
//  DYDataService.m
//  MyMovie
//
//  Created by 邓奕 on 15/9/4.
//  Copyright (c) 2015年 文华. All rights reserved.
//

#import "DYDataService.h"
#import "BaseModel.h"

@implementation DYDataService

+ (id)requestDataWithJSONFileName:(NSString *)fileName {
    // 1.获取JSON文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    // 2.构造Data
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    /**
     *  序列化JSON数据 容器
     iOS 5.0 之后 系统提供了解析JSON框架。之前需要借助第三方框架
     *
     *  @param NSData 需要解析JSON 数据
     *
     *  @return 数组或者字典
     */
     return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+ (NSMutableArray *)modelArrayWithJSONFileName:(NSString *)fileName forModelClass:(Class)modelClass {
    NSArray *resultArray = [self requestDataWithJSONFileName:fileName];
    
    if (![resultArray isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return [self modelArrayWithArrayForDictionary:resultArray forModelClass:modelClass];
}

+ (NSMutableArray *)modelArrayWithArrayForDictionary:(NSArray *)array forModelClass:(Class)modelClass {
    // 存放模型的数组
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:array.count];
    
    // 遍历存放字典的数组
    for (NSDictionary *contentDic in array) {
        // 将字典转成模型
        id model = [[modelClass alloc] initWithJSONDictionaray:contentDic];
        // 存放模型
        [modelArray addObject:model];
    }
    
    return modelArray;

}

@end
