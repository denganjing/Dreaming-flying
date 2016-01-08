//
//  ChatModel.h
//  TheGoodNight
//
//  Created by imac on 15/10/28.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *icon;
 // 是否是自己发送的消息
@property (nonatomic, assign) BOOL isSelf;
@end
