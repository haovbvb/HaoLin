//
//  JZDItem.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZDItem : NSObject
//详情页cell的item属性
@property (nonatomic,copy) NSString *answerDes;
@property (nonatomic,copy) NSString *describeString;
@property (nonatomic,strong) UIImage *partyImage;
@property (nonatomic,copy) NSString *nickName;//这个属性可以公用
@property (nonatomic,copy) NSString *evaluateTimeDate;
@property (nonatomic,copy) NSString *publishOfMe;
//宠物和聚会cell的item属性
@property (nonatomic,strong) UIImage *headImage;//这个属性可以公用
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *numberOfPeople;
@property (nonatomic,copy) NSString *doSomeThing;
@property (nonatomic,copy) NSString *timeForStart;
@property (nonatomic,copy) NSString *timeForNow;
@property (nonatomic,copy) NSString *partyDescribe;
@property (nonatomic,copy) NSString *farAway;
//详情页的评论
@property (copy, nonatomic) NSString *publishTimeString;
@property (copy, nonatomic) NSString *publishContentString;
@property (nonatomic,copy) NSString *bbsTheme;
//同意列表
@property (nonatomic,copy) NSString *sinceTime;
@property (nonatomic,copy) NSString *phoneNum;
@property (nonatomic,copy) NSString *qqString;
@property (nonatomic,copy) NSString *j_s_t;
//获取两个点间的距离
@property (nonatomic,assign) double disTance;

@property (nonatomic,strong) NSMutableArray *iamgeArray;

@property (nonatomic,copy) NSString *boyOrGirl;

//二手商品
@property (nonatomic,copy) NSString *used_title;
@property (nonatomic,copy) NSString *used_price;
@property (nonatomic,copy) NSString *used_addtime;
@property (nonatomic,strong) NSMutableArray *picArray;
@property (nonatomic,copy) NSString *headImageUrl;
@end
