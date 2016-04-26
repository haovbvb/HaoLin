//
//  ZYPShopAddressVC.h
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MQLPersonalHanDanDataManage;
@interface ZYPShopAddressVC : UIViewController
@property (nonatomic, strong)NSString *addressTEXT;
@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) MQLPersonalHanDanDataManage *DManage;


@end
