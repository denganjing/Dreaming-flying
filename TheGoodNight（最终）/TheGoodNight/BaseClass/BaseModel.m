//
//  BaseModel.m
//  映射模型
//
//  Created by 邓奕 on 15/9/4.
//  Copyright (c) 2015年 文华. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithJSONDictionaray:(NSDictionary *)JSONDic {
    self = [super init];
    if (self) {
        [self setJSONModelWithDictionary:JSONDic];
    }
    
    return self;
}

- (void)setJSONModelWithDictionary:(NSDictionary *)JSONDic {
    // 1.存储对应关系，JSON字典的key 和 模型中的 属性联系起来
    // @"name" : @"name"
    // @"id"   : @"类名+ID"
    NSDictionary *relationshipDic = [self buildRelationship:JSONDic];
    
    // 2.根据已经构造好的关系，生成设置器方法
    // @"name" -> @"setName:"
    for (NSString *keyName in relationshipDic) {
        
        // 获取属性名
        NSString *modelPropertyName = relationshipDic[keyName];
        SEL selector = [self pendingSetterMethod:modelPropertyName];
        
        // 从JSON字典取出 需要设置成model属性的值
        id JSONValue = JSONDic[keyName];
        
        // 强健性判断
        if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:JSONValue];
#pragma clang diagnostic pop
        }
        
    }
}

// 字符串改写方法：获取特殊的属性名
- (NSDictionary *)buildRelationship:(NSDictionary *)JSONDic {
    
    NSMutableDictionary *relationshipDic = [NSMutableDictionary dictionary];
    // 获取特殊关系 ： 「id」 -> 「类名+id」
    for (NSString *key in JSONDic) {
        // 将id筛选出来
        if ([key isEqualToString:@"id"]) {
            // 「id」 -> 「类名+id」
            NSString *className = NSStringFromClass([self class]);
            
            // 1.BaseModel -> baseModel
            NSString *firstChar = [[className substringToIndex:1] lowercaseString];
            NSString *otehrString = [className substringFromIndex:1];
            
            // 拼接
            NSString *propertyName = [NSString stringWithFormat:@"%@%@ID", firstChar, otehrString];
            
            [relationshipDic setObject:propertyName forKey:key];
        } else {
            [relationshipDic setObject:key forKey:key];
        }
    }
    return relationshipDic;
}

// 字符串改写方法：构造 setter
- (SEL)pendingSetterMethod:(NSString *)modelPropertyName {
   
    // 「name」 -> 「setName:」
    // 构造对应的方法签名
    NSString *firstChar = [[modelPropertyName substringToIndex:1] uppercaseString];
    NSString *otehrString = [modelPropertyName substringFromIndex:1];
    
    // 拼接字符串
    // setAge:
    NSString *setterString = [NSString stringWithFormat:@"set%@%@:", firstChar, otehrString];
    // 构造方法签名
    return NSSelectorFromString(setterString);
}




@end
