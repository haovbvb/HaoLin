//
//  ZYPMapViewController.h
//  HaoLin
//
//  Created by mac on 14-8-27.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MQLPersonalHanDanDataManage;
@class CLLocation;
//  代理方法
@protocol ZYPMapViewControllerDelegate <NSObject>
- (void)getLocation:(MQLPersonalHanDanDataManage *)manger  boolZ:(BOOL)D;
@end
@interface ZYPMapViewController : UIViewController


@property (nonatomic ,strong)NSString *addressStr;
@property (nonatomic, assign)id<ZYPMapViewControllerDelegate> delegate;
@property (nonatomic, strong) MQLPersonalHanDanDataManage *DataManage;
@end
