//
//  ZYPRegiseterViewController.h
//  HaoLin
//
//  Created by mac on 14-8-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPRegiseterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nickName;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *getAuthenticationNumber;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UITextField *samePassWord;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end
