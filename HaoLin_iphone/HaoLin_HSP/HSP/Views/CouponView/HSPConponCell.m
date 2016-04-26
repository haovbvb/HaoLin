//
//  HSPConponCell.m
//  HaoLin
//
//  Created by PING on 14-8-26.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPConponCell.h"
#define noUsedColor [UIColor lightGrayColor]

@implementation HSPConponCell
@synthesize conpon = _conpon;
- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = HSPSubBgColor;
}

- (HSPConpon *)conpon
{
    return _conpon;
}

- (void)setConpon:(HSPConpon *)conpon
{
    _conpon = conpon;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:conpon.coupon_price];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"元"];
    [str appendAttributedString:str1];
    NSString *str2 = [NSString stringWithFormat:@"%@元",conpon.coupon_price];
    NSRange yuan = [str2 rangeOfString:@"元"];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(yuan.location, yuan.length)];
    
    _conponPrice.attributedText = str;
    _conponCode.text = conpon.coupon_code;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    NSString *beginTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[conpon.begintime doubleValue]]];
    NSString *endTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[conpon.endtime doubleValue]]];
    
    _LimitedTime.text = [NSString stringWithFormat:@"%@至%@",beginTime,endTime];
    
    if ([conpon.status isEqualToString:@"2"]) {
        _status.text = @"有效";
        
    }else{
        _status.text = @"无效";
        _status.textColor = noUsedColor;
        _conponPrice.textColor = noUsedColor;
        _conponCode.textColor = noUsedColor;
        _LimitedTime.textColor = noUsedColor;
        _limitedTimeTitle.textColor = noUsedColor;
        _conponCodeTitle.textColor = noUsedColor;
        _conponPriceTitle.textColor = noUsedColor;

    }
    
    
}




@end
