//
//  ZYPInformationViewCC.h
//  HaoLin
//
//  Created by mac on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    systemInfo,
    orderInfo
}Information;
@interface ZYPInformationViewCC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic,assign)Information info;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
