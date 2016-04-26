//
//  MQLSendHanDanViewController.h
//  HaoLin
//
//  Created by maqianli on 14-8-21.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCustomViewController.h"

@class MQLPersonalHanDanDataManage;
@interface MQLSendHanDanViewController : MQLCustomViewController

@property (nonatomic, strong) NSDictionary *selectedHanDankind;     //选中的喊单分类
@property (nonatomic, strong) MQLPersonalHanDanDataManage *personalHanDanDataManage;

@property (nonatomic, strong) UIViewController *fromVC;

@end
