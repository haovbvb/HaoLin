//
//  JZDPartyDetailViewController.h
//  HaoLin
//
//  Created by 姜泽东 on 14-8-11.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZDPartyDetailViewController : UIViewController

@property (nonatomic,copy) NSString *outOfDute;
@property (nonatomic,copy) NSString *thisUrl;
@property (nonatomic,copy) NSString *groupId;
@property (nonatomic,assign) double farAwayString;
//聚会要做的事情
@property (weak, nonatomic) IBOutlet UILabel *doSomeThing;
//聚会位置
@property (weak, nonatomic) IBOutlet UILabel *location;
//人数上线
@property (weak, nonatomic) IBOutlet UILabel *numPeople;
//发布时间
@property (weak, nonatomic) IBOutlet UILabel *timeDate;
//聚会开始时间
@property (weak, nonatomic) IBOutlet UILabel *startTime;

- (IBAction)applyPetsParty:(UIButton *)sender;
//报名人数
@property (weak, nonatomic) IBOutlet UILabel *joinPeople;
@property (weak, nonatomic) IBOutlet UITableView *petDetailTableView;
@property (weak, nonatomic) IBOutlet JZDCheckButton *farAway;

@property (nonatomic, copy) NSString *voicePath;
@property (nonatomic, copy) NSString *voiceName;
//上部scrollview
@property (weak, nonatomic) IBOutlet UIScrollView *highScrollView;
//用户内容底部
@property (strong, nonatomic) IBOutlet UIView *bottomView;
//聚会发起人头像
@property (weak, nonatomic) IBOutlet UIButton *userHeadImage;
//发起人id
@property (weak, nonatomic) IBOutlet UILabel *userName;
//聚会内容说明
@property (copy, nonatomic) NSString *describeString;
//说明部分底部
@property (weak, nonatomic) IBOutlet UIView *tellBottomView;
- (IBAction)palyTheVoice:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *click_num;
@property (weak, nonatomic) IBOutlet UIView *smallImageShow;
@property (weak, nonatomic) IBOutlet UIImageView *userSex;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


@property (weak, nonatomic) IBOutlet JZDCheckButton *play;
@property (weak, nonatomic) IBOutlet UITableView *littleTableView;
@end
