//
//  MQLPersonalHanDanDataManage.m
//  HaoLin
//
//  Created by MQL on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLPersonalHanDanDataManage.h"

@implementation MQLPersonalHanDanDataManage

-(id)init
{
    self = [super init];
    if (self) {
        
        self.charaters = @"";
        self.wavFilePath = @"";
        self.serviceCharge = 3;
        self.sendAddress = @"";
        self.pushBusinessScope = nil;
    }
    
    return self;
    
}

@end
