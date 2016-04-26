//
//  MQLSendAddressCellInSendHanDanView.m
//  HaoLin
//
//  Created by MQL on 14-8-25.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLSendAddressCellInSendHanDanView.h"

@interface MQLSendAddressCellInSendHanDanView ()

@property (nonatomic, weak) IBOutlet UILabel *sendAddressLab;
@property (nonatomic, weak) IBOutlet UIButton *editBtn;


-(IBAction)editBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;



@end

@implementation MQLSendAddressCellInSendHanDanView
-(void)dealloc
{

}

- (void)awakeFromNib
{
    // 自定义初始化
    [self customInitialization];
    
}

-(void)setPersonalHanDanDataManage:(MQLPersonalHanDanDataManage *)personalHanDanDataManage
{
    _personalHanDanDataManage = personalHanDanDataManage;
    self.sendAddressLab.text = personalHanDanDataManage.sendAddress;
    
    //调整lab高度
    CGSize constraint = CGSizeMake(self.sendAddressLab.bounds.size.width, CGFLOAT_MAX);
    CGSize size = [self boundingRectWithSize:constraint withFont:self.sendAddressLab.font withText:self.sendAddressLab.text];
    float height = size.height > 21.473999 ? size.height + (40 - 21.473999) : 40;
    
    CGRect oldFrame = self.sendAddressLab.frame;
    self.sendAddressLab.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, height);
}

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(UIFont*)font withText:(NSString*)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

#pragma mark -- MQLSendAddressCellInSendHanDanView函数扩展

-(IBAction)editBtnClicked:(id)sender
{
    if ([self.delegage respondsToSelector:@selector(sendAddressEditBtnClicked)]) {
        
        [self.delegage sendAddressEditBtnClicked];
    }
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{

}


@end
