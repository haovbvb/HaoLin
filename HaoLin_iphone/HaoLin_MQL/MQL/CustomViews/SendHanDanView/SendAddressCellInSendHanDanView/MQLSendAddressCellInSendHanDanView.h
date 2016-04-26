//
//  MQLSendAddressCellInSendHanDanView.h
//  HaoLin
//
//  Created by MQL on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MQLPersonalHanDanDataManage;

@protocol MQLSendAddressCellInSendHanDanViewDelegate <NSObject>

-(void)sendAddressEditBtnClicked;

@end

@interface MQLSendAddressCellInSendHanDanView : UITableViewCell

@property (nonatomic, strong) MQLPersonalHanDanDataManage *personalHanDanDataManage;
@property (nonatomic, weak) id<MQLSendAddressCellInSendHanDanViewDelegate> delegage;


@end
