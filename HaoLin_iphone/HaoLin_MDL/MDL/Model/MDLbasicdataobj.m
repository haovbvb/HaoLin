//
//  MDLbasicdataobj.m
//  HaoLin
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MDLbasicdataobj.h"

@implementation MDLbasicdataobj

static  MDLbasicdataobj * basicdataobj =nil;

+(MDLbasicdataobj *)sharebasicdataobj
{
    if (basicdataobj==nil) {
        basicdataobj=[[MDLbasicdataobj alloc]init];
    }
    return basicdataobj;
}
@end
