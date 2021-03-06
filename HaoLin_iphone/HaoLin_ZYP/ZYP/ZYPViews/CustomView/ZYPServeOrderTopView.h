//
//  ZYPServeOrderTopView.h
//  HaoLin
//
//  Created by mac on 14-9-20.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MQLPetsViewController;
@class ZYPServerViewController;
@class ZYPServeOrderView;
@interface ZYPServeOrderTopView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)ZYPServeOrderView *orderView;
@property (nonatomic, strong)MQLPetsViewController *petVC;
@property (nonatomic, strong)ZYPServerViewController *serveVC;


@end
