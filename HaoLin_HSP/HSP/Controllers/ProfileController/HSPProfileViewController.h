//
//  HSPProfileViewController.h
//  HaoLin
//
//  Created by PING on 14-8-24.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPProfileViewController : UITableViewController

/**
 *  要加载plist的数据文件名称
 */
@property (nonatomic, copy) NSString *dataFileName;
// 数据列表
@property (nonatomic, strong) NSArray *dataList;


@end
