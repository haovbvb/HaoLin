//
//  ZYPActiveDescVC.h
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPActiveDescVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *activeDescTextView;

@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong)NSString *activeText;
@end
