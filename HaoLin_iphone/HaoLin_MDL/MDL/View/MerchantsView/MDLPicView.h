//
//  MDLPicView.h
//  HaoLin
//
//  Created by apple on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDLPicView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel     *picname;
@property (weak, nonatomic) IBOutlet UITextField *pictext;
@property (weak, nonatomic) IBOutlet UIButton    *quedingbtn;
@property (weak, nonatomic) IBOutlet UIButton    *quxiaobtn;
@property (weak, nonatomic) IBOutlet UIImageView *beijingimage;
@property (weak, nonatomic) IBOutlet UIImageView *fengeimage;

@end
