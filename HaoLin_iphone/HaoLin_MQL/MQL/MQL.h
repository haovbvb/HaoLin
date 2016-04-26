//
//  MQL.h
//  HaoLin
//
//  Created by mac on 14-8-7.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//



#import "MQLAppDelegate.h"
#import "MQLCustomTabBarController.h"
#import "MQLCustomNavigationController.h"
#import "MQLCustomViewController.h"


#import "MQLPersonalViewController.h"
#import "MQLBusinessViewController.h"
#import "MQLPartyViewController.h"
#import "MQLPetsViewController.h"

#import "MQLCustomTabBar.h"
#import "MQLPersonalView.h"
    #import "MQLHanDanKindsView.h"
    #import "MQLAdViewInPersonalView.h"
        #import "CycleADScrollView.h"
        #import "NSTimer+Ad.h"

#import "MQLLoginViewController.h"
    #import "MQLLoginView.h"

#import "MQLDeviceDataManage.h"
#import "MQLBMKMapManage.h"
#import "MQLPersonalHanDanDataManage.h"
#import "MQLHttpRequestManage.h"
#import "MQLShiWuOrFuWuConfirmOrderFormDataManage.h"

#import "MQLGoodDataManage.h"
    #import "MQLGoodItemInfo.h"

#import "MQLCashCouponDataManage.h"
    #import "MQLCashCouponItemInfo.h"

#import "MQLPayModeDataManage.h"
    #import "MQLPayModeItemInfo.h"



#import "MQLCharacterOrAudioHanDanViewController.h"
    #import "MQLCharacterOrAudioHanDanView.h"
        #import "MQLHanDanCharacterInputView.h"
        #import "MQLHanDanAudioRecordView.h"
            #import "VoiceConverter.h"
            #import "MQLAudioManage.h"
            #import "MQLRecordOperation.h"
            #import "MQLRecordingStatusView.h"
            #import "SCGIFImageView.h"

#import "MQLSendHanDanViewController.h"
    #import "MQLSendHanDanView.h"
        #import "MQLTryListenCellInSendHanDanView.h"
        #import "MQLCharacterCellInSendHanDanView.h"
        #import "MQLServiceChargeCellInSendHanDanView.h"
        #import "MQLServiceChargeSelectorView.h"
        #import "MQLSendAddressCellInSendHanDanView.h"
        #import "MQLPushBusinessScopeCellInSendHanDanView.h"
        #import "MQLConfirmOrAgainCellInSendHanDanView.h"
#import "MQLSendAddressInputView.h"

#import "MQLRequiredBusinessLocationViewController.h"
    #import "MQLRequiredBusinessLocationView.h"

#import "MQLHanDanWaitingViewController.h"
    #import "MQLHanDanWaitingView.h"
        #import "MQLTimerViewInHanDanWaitingView.h"
        #import "MQLAdViewInHanDanWaitingView.h"
        #import "MQLHanDanNoResponseView1.h"
        #import "MQLHanDanNoResponseView2.h"

#import "MQLShiWuOrFuWuConfirmOrderFormViewController.h"
    #import "MQLShiWuOrFuWuConfirmOrderFormView.h"
        #import "MQLShiWuConfirmOrderFormView.h"
            #import "MQLCellOfSection0InShiWuConfirmTableView.h"
            #import "MQLCellOfSection1InShiWuConfirmTableView.h"
            #import "MQLCellOfSection2InShiWuConfirmTableView.h"
            #import "MQLCellOfSection3InShiWuConfirmTableView.h"
            #import "MQLCellOfSection4InShiWuConfirmTableView.h"
            #import "MQLCellOfSection5InShiWuConfirmTableView.h"
            #import "MQLCellOfSection6InShiWuConfirmTableView.h"


        #import "MQLFuWuConfirmOrderFormView.h"

#import "MQLShiWuFinishOrderFormViewController.h"
    #import "MQLShiWuFinishOrderFormView.h"

#import "MQLAdDetailViewController.h"
    #import "MQLAdDetailView.h"

#import "MQLAppGuideViewController.h"
#import "MQLAppGuideView.h"


#define MQLBGColor [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]
#define BGOrangeColor [UIColor colorWithRed:255.0/255 green:75.0/255 blue:0.0/255 alpha:1.0]
#define NetworkError 404

#define NotificationOfIntoRootView @"NotificationOfIntoRootView"

#define NotificationOfPersonalHanDanRequestOver @"NotificationOfPersonalHanDanRequestOver"
#define NotificationOfHanDanDetailRequestOver @"NotificationOfHanDanDetailRequestOver"
#define NotificationOfSubmitRequestOfShiWuConfirmOrderFormOver @"NotificationOfSubmitRequestOfShiWuConfirmOrderFormOver"
#define NotificationOfAdInPersonalRequestOver @"NotificationOfAdInPersonalRequestOver"
#define NotificationOfAdInHanDanWaitingRequestOver @"NotificationOfAdInHanDanWaitingRequestOver"

#define NotificationOfSendToBusiness @"NotificationOfSendToBusiness"    //发送给商家的通知
#define NotificationOfSendToPersonal @"NotificationOfSendToPersonal"    //发送给个人的通知


//#define UrlHost @"http://192.168.1.88:7878"
#define UrlHost @"http://t9.wxwork.cn"
#define UrlOfPersonalHanDan @"/home/order/talkto"                   //个人喊单
#define UrlOfHanDanDetail @"/home/order/talkinfos"                  //喊单详情
#define UrlOfSubmitShiWuConfirmOrderForm @"/home/order/setorder"    //提交“实物确认订单”
#define UrlOfAdInPersonal @"/index.php?m=home&c=poster&a=posterLists&posterid=1&deviceid=1" //首页广告
#define UrlOfAdInHanDanWaiting @"/index.php?m=home&c=poster&a=posterLists&posterid=2&deviceid=1" //喊单等待页广告





