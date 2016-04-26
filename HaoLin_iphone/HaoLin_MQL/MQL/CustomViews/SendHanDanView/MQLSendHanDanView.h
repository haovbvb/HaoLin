//
//  MQLSendHanDanView.h
//  HaoLin
//
//  Created by maqianli on 14-8-21.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLPersonalHanDanDataManage;
@interface MQLSendHanDanView : UIView

@property (nonatomic, weak) UIViewController *ownerViewController;  //所属控制器
@property (nonatomic, strong) NSDictionary *selectedHanDankind;     //选中的喊单分类
@property (nonatomic, strong) MQLPersonalHanDanDataManage *personalHanDanDataManage;

/**
 *  刷新contentTableView
 */
-(void)refreshContentTableView;

/*
 注册键盘通知事件
 */
-(void)registerForKeyboardNotifications;

/**
 *  注销键盘通知事件
 */
-(void)resignForKeyboardNotifications;



@end
