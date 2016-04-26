//
//  ZYPAddImageCell.h
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ZYPCompleteinfoVC;
@interface ZYPAddImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *businessLicenseImage;
@property (weak, nonatomic) IBOutlet UIImageView *IDIamge;
@property (weak, nonatomic) IBOutlet UIImageView *healthImage;
@property (weak, nonatomic) IBOutlet UIImageView *IDImageF;


@property (nonatomic, strong)ZYPCompleteinfoVC *compleVC;
@end
