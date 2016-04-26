//
//  MDLbasicdataobj.h
//  HaoLin
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDLbasicdataobj : NSObject

@property (nonatomic,retain)NSString *talkid;             //会话ID
@property (nonatomic,assign)NSString *catid;              //分类ID
@property (nonatomic,retain)NSString *useraxis;           //经纬度
@property (nonatomic,retain)NSMutableArray *goodsinfo;    //选择的商品
@property (nonatomic,retain)NSString *catname;            //名称
@property (nonatomic,retain)NSString *createtime;         //时间

@property (nonatomic,retain)NSMutableArray *xzdata;       //选择分类



+(MDLbasicdataobj *)sharebasicdataobj;

@end
