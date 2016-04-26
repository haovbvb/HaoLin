//
//  JZDImgTableViewCell.h
//  HaoLin
//
//  Created by Zidon on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDImgTableViewCell : UITableViewCell
{
    NSMutableArray *arr;
}
@property (nonatomic,strong) JZDItem *item;
@property (nonatomic,strong) NSArray *picArray;
@property (weak, nonatomic) IBOutlet UIButton *imgBtnOne;
@property (weak, nonatomic) IBOutlet UIButton *imgBtnTwo;
@property (weak, nonatomic) IBOutlet UIButton *imgBtnThree;
@property (nonatomic,strong) NSMutableArray *btnArray;
- (IBAction)clickImage:(UIButton *)sender;
@end
