//
//  MQLServiceChargeSelectorView.h
//  HaoLin
//
//  Created by MQL on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQLServiceChargeSelectorViewDelegate <NSObject>

-(void)serviceChargeSelectorValueChanged:(int)value;

@end

@interface MQLServiceChargeSelectorView : UIView

@property (nonatomic, weak) id<MQLServiceChargeSelectorViewDelegate> delegate;
@property (nonatomic) int serviceCharge;                //服务费

@end
