//
//  ZYPServeOrderView.h
//  HaoLin
//
//  Created by mac on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>



@class MQLPetsViewController;
@class ZYPServerViewController;
@interface ZYPServeOrderView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
}
@property (nonatomic,strong)NSMutableArray *sourceArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSString *string;
@property (nonatomic, strong)MQLPetsViewController *petVC;
@property (nonatomic, strong)ZYPServerViewController *serveVC;
- (void)allServe:(NSString *)str;
- (void)waitToServe:(NSString *)str;
- (void)alreadyServe:(NSString*)str;
@end
