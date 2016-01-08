//
//  GroundModel.m
//  TheGoodNight
//
//  Created by imac on 15/10/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "GroundModel.h"

@implementation GroundModel


+(NSArray *)requestModelsWithJSONDictionaray:(NSDictionary *)JSONDic
{
    NSMutableArray *models = [NSMutableArray array];
    
    NSArray *user = JSONDic[@"userList"][@"user"];
    
    NSArray *card = JSONDic[@"card"];
    
    for (NSDictionary *contentDic in card) {
        
        GroundModel *groundModel  = [[GroundModel alloc] initWithJSONDictionaray:contentDic];
        
        for (NSDictionary *userDic in user) {
            
            if ([userDic[@"uid"] isEqualToString:groundModel.uid]) {
                groundModel = [groundModel initWithJSONDictionaray:userDic];
            }
            
        }
        [models addObject:groundModel];
    }
return models;
    
   }

@end
