//
//  HSPProfileTopView.m
//  HaoLin
//
//  Created by PING on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPProfileTopView.h"

@interface HSPProfileTopView ()

@end

@implementation HSPProfileTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.topBgImage.userInteractionEnabled = YES;
    }
    return self;
}

-(void)awakeFromNib
{
    
}

- (IBAction)partyBtnClick:(id)sender {

}
- (IBAction)petBtnClick:(id)sender {
    
}


@end
