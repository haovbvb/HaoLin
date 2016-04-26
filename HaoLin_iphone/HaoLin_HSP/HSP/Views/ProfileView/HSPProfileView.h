//
//  HSPProfileView.h
//  HaoLin
//
//  Created by PING on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPProfileView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) UIViewController  *HSPProfileViewController;

@property (weak, nonatomic) IBOutlet UITableView *adjustTableView;
@property (weak, nonatomic) IBOutlet UIView *navBgView;

@end
