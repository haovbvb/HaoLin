//
//  HSPMessage.h
//  HaoLin
//
//  Created by PING on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSPMessage : NSObject

// 代金券id
@property (nonatomic, copy) NSString *message_id;
// 消息类型（1.订单消息，2.系统消息），暂时不做订单消息，消息列表中所有的消息都是系统消息
@property (nonatomic, copy) NSString *message_type;
// 消息内容
@property (nonatomic, copy) NSString *message_desc;
// 发布时间
@property (nonatomic, copy) NSString *createtime;
// 读取状态（1.已读，0.未读）
@property (nonatomic, copy) NSString *isread;



@end
