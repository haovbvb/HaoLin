//
//  JZDPublishSecViewController.h
//  HaoLin
//
//  Created by Zidon on 14-9-10.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZDCheckButton;

@interface JZDPublishSecViewController : UIViewController



@property (nonatomic,assign) int segSelected;

@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (weak, nonatomic) IBOutlet UITextField *buyTheme;
@property (weak, nonatomic) IBOutlet UITextField *buyPrice;
- (IBAction)showCateGray:(JZDCheckButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *showCateGray;
@property (weak, nonatomic) IBOutlet UITextView *detailDescribe;
@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;
- (IBAction)addImageBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *contactPerson;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneNum;
- (IBAction)commitBtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *addView;
- (IBAction)resignTheKeyBoard:(UITapGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *backTheKeyBoard;

@property (weak, nonatomic) IBOutlet UILabel *nubTextLable;
@end
