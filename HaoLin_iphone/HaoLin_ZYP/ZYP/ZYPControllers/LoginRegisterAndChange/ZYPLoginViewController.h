//
//  ZYPLoginViewController.h
//  HaoLin
//
//  Created by mac on 14-8-22.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ZYPLoginInformation;
typedef void (^CallBackLogin)(ZYPLoginInformation *infor);
@interface ZYPLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextF;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (nonatomic, strong)UIViewController *MQLBusinessViewController;
@property (nonatomic, assign)CallBackLogin inforLogin;
@end
