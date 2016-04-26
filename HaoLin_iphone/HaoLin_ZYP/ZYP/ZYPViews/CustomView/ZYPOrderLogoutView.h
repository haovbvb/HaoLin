//
//  ZYPOrderLogoutView.h
//  HaoLin
//
//  Created by mac on 14-9-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MQLPetsViewController;
@interface ZYPOrderLogoutView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *dangerImageview;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@property (nonatomic, strong)MQLPetsViewController *petVC;



@end
