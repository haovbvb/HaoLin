//
//  Main.h
//  HaoLin
//
//  Created by mac on 14-8-7.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//


#import "JZDPartyAddView.h"
#import "JZDPetsAddViewController.h"
#import "JZDApplyViewController.h"
#import "JZDPublishViewController.h"
#import "JZDPetsActivityViewController.h"
#import "JZDPetsBBSViewController.h"
#import "PetsDetailViewController.h"
#import "JZDsPetsPartyViewController.h"
#import "JZDPartyDetailViewController.h"
#import "JZDSPartyViewController.h"
#import "JZDModuleHttpRequest.h"
#import "JZDImageView.h"
#import "JZDCheckButton.h"
#import "JZDItem.h"
#import "JZDSectionView.h"
#import "JZDBBsSectionView.h"
#import "JZDPartyTableViewCell.h"
#import "JZDPartyDetailTableViewCell.h"
#import "JZDPartyDetailVoiceTableViewCell.h"
#import "JZDDeatilDecribeTableViewCell.h"
#import "JZDBBSTableViewCell.h"
#import "JZDPartyAddView.h"
#import "JZDPetsAddViewController.h"
#import "JSONKit.h"
#import "NSTimer+Addition.h"
#import "JZDScrollView.h"
#import "JZDImageDownLoad.h"
#import "JZDImageDownLoad.h"
#import "JZDCustomAlertView.h"
#import "JZDTakeInTableViewCell.h"
#import "JZDTakeInViewController.h"
#import "JZDEvaluateViewController.h"
#import "MJRefresh.h"
#import "JZDBBsEvaluateViewController.h"
#import "JZDBBsIntroTableViewCell.h"
#import "UIImage+JZDImage.h"
#import "JZDPublishBBSViewController.h"
#import "MyJoinTableViewCell.h"
#import "JZDBBsEvaluteViewController.h"
#import "JZDDistance.h"
#import "JZD_loopView.h"
#import "JZDBottomView.h"
#import "JZDShowPicViewController.h"
#import "JZDPhoto_album.h"
#import "JZDImgScrollView.h"
#import "JZDNavgationViewController.h"
#import "JZDNavgationBar.h"
#import "JZDAlertViewShow.h"
#import "JZDSec_handViewController.h"
#import "SecListTableViewCell.h"
#import "JZDSec_detailViewController.h"
#import "JZDDecTableViewCell.h"
#import "JZDImgTableViewCell.h"
#import "JZDPublishSecViewController.h"
#import "JZDPubTransferViewController.h"
#import "JZD_Menu.h"
#import "RegexKitLite.h"
#import "JZDPushSingl.h"
#import "JZDLoop_ScrollView.h"
#import "JZDNoNetWorkView.h"

#define MDLCommit @"HanDanResult"

#ifdef DEBUG
# define YYLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define YYLog(...)
#endif

#define device_is_iphone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640,1136),[[UIScreen mainScreen] currentMode].size):NO)

#define BaseAddress @"http://t9.wxwork.cn/index.php"
//宠物活动列表
#define PetsPartyListUrl @"http://t9.wxwork.cn/index.php?m=home&c=group&a=lists&type=1&page=%d"
//我发起的宠物活动
#define PetsOfMain @"http://t9.wxwork.cn/index.php?m=home&c=space&a=mySendGroup&user_id=%@&type=1&page=%d&tokenid=%@"
//我申请的宠物活动列表
#define PetsOfMeApply @"http://t9.wxwork.cn/index.php?m=home&c=space&a=myJoinGroupList&user_id=%@&type=1&page=%d&tokenid=%@"
//查看报名我的活动的同意状况列表
#define CheckAgreePetsParty @"http://t9.wxwork.cn/index.php?m=home&c=space&a=myGroupOneApply&user_id=%@&group_id=%@&page=%@&tokenid=%@"
//报名
#define ApplyPetsParty @"http://t9.wxwork.cn/index.php?m=home&c=group&a=addApply&tokenid=%@"
//论坛列表
#define BBS @"http://t9.wxwork.cn/index.php?m=home&c=forum&a=forumLists&page=%d"
//论坛-详细
#define BBSDetail @"http://t9.wxwork.cn/index.php?m=home&c=forum&a=remarkList&posts_id=%@&page=%d"
//同意-拒绝
#define AgreeOrRefuse @"http://t9.wxwork.cn/index.php?m=home&c=space&a=myGrouopEditStats&user_id=%@&group_id=%@&request_id=%@&status=%@&tokenid=%@"
//发布宠物活动
#define PublishActivity @"http://t9.wxwork.cn/home/group/addGroup"
//宠物活动评价借口
#define Evaluate @"http://t9.wxwork.cn/index.php?m=home&c=group&a=addRemark"

#define EvaluateBBS @"http://t9.wxwork.cn/index.php?m=home&c=forum&a=postsRemark&tokenid=%@"

#define PublishBBs @"http://t9.wxwork.cn/index.php?m=home&c=forum&a=posts"

//二手商品   t9.wxwork.cn  t9.wxwork.cn
//列表
#define SecList @"http://t9.wxwork.cn/index.php?m=home&c=used&a=lists&type=%d&categoryType=%@&page=%d"
//物品详情
#define DetailSec @"http://t9.wxwork.cn/index.php?m=home&c=used&a=show&id=%@"
//获取搜索的分类
#define GetTheCategray @"http://t9.wxwork.cn/index.php?m=home&c=used&a=category"
//搜索二手物品
#define searchSecGoods @"http://t9.wxwork.cn/index.php?m=home&c=used&a=search&page=%d"
//发布二手物品求购或转让
#define publishSecGoods @"http://t9.wxwork.cn/index.php?m=home&c=used&a=addUsed"

#define PushSingl @"http://t9.wxwork.cn/home/order/talkinfos"
#define CommitHanDan @"http://t9.wxwork.cn/home/order/grabto"

//报名验证借口
#define ApplyCheck @"http://t9.wxwork.cn/index.php?m=home&c=group&a=checkUserIsApply&group_id=%@&user_id=%@&tokenid=%@"
#define NoWay @"0.000000"
#define NoWayDouble 0.000000