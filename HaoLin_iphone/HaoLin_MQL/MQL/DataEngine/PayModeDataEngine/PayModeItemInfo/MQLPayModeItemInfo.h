//
//  MQLPayModeItemInfo.h
//  HaoLin
//
//  Created by MQL on 14-9-17.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQLPayModeItemInfo : NSObject

@property (nonatomic, copy) NSString *payModeName;  //支付方式名
@property (nonatomic) BOOL isSelected;              //是否被选中

@end
