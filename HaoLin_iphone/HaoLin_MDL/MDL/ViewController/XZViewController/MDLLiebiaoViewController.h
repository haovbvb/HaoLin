//
//  MDLLiebiaoViewController.h
//  HaoLin
//
//  Created by apple on 14-9-13.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDLLiebiaoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLable;
@property (weak, nonatomic) IBOutlet UIButton    *backbtn;
@property (nonatomic ,strong) NSMutableArray     *processingarry;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *nvbarview;

@property (nonatomic,copy) NSDictionary *(^dicBlock)(void);
@end
