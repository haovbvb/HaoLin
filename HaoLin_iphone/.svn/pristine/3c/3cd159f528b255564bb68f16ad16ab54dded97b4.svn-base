//
//  ZYPBankSelectedVC.h
//  HaoLin
//
//  Created by mac on 14-9-10.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CallBackBank)(NSString *bankName,NSInteger code);//  回调block
@interface ZYPBankSelectedVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)callBack:(CallBackBank)block;
@end
