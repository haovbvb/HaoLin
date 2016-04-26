//
//  MDLMercHantView.h
//  HAOLINAPP
//
//  Created by apple on 14-8-10.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface MDLMercHantView : UIView<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

/**
 * UIButton *lestButton      :返回键
 * UIButton *rightButton     :右边button
 * UIView   *navgaionbarview :导航
 * UIImageView    *iv        :圆圈背景
 * UITableView    *informationtableView :首页表示图
 */

@property (nonatomic,retain)UIViewController  *MQLBusinessViewController;
@property (weak, nonatomic) IBOutlet UIButton *lestButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIView   *navgaionbarview;
@property (nonatomic ,strong)  UITableView    *informationtableView;
@property (nonatomic ,strong)  UIImageView    *iv;
@property (nonatomic ,strong)  UIView         *cgview;
@property (nonatomic ,assign)  int            pid;

-(void)audiobtn:(UIButton *)btn;

@end
