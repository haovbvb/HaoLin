//
//  ZYPHomeView.h
//  HaoLin
//
//  Created by mac on 14-9-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQLPartyViewController;
@interface ZYPHomeView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    BOOL state;
    ZYPLoginView *loginView1;
    ZYPHomeBottomView *bottomView;
    UIView *view;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;


@property (nonatomic, strong)NSMutableArray *allArray;
@property (nonatomic, strong)MQLPartyViewController *partVC;
- (void)logoutInfo;
@end
