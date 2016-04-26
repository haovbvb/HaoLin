//
//  HSPMessageDetaildController.m
//  HaoLin
//
//  Created by PING on 14-10-10.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPMessageDetaildController.h"

@interface HSPMessageDetaildController ()

@end

@implementation HSPMessageDetaildController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    self.inforLabel.font = [UIFont systemFontOfSize:17];
    self.inforLabel.layer.cornerRadius = 6;
    self.inforLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    NSString *str = [self timeTranslate:self.infoObject.createtime];
    self.timeLabel.text = [NSString stringWithFormat:@"时间:%@",str];
    self.inforLabel.lineBreakMode=NSLineBreakByCharWrapping;
    self.inforLabel.numberOfLines = 0;
    self.inforLabel.layer.borderWidth = 1;
    self.inforLabel.text = self.infoObject.message_desc;
    CGFloat height = [self heightOfLabelFromString:self.infoObject.message_desc];
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
        if (height < 80) {
            height = 80;
            self.scrollView.contentSize = CGSizeMake(320, 550);
            self.inforLabel.frame = CGRectMake(30, 60, 260, height);
        }else if (height > 450){
            self.inforLabel.frame = CGRectMake(30, 60, 260, height);
            self.scrollView.contentSize = CGSizeMake(320, height + 100);
        }
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
        self.scrollView.frame = CGRectMake(0, 64, 320, 416);
        if (height < 80) {
            height = 80;
            self.scrollView.contentSize = CGSizeMake(320,500);
            self.inforLabel.frame = CGRectMake(30, 60, 260, height);
        }else if (height > 362)
            self.inforLabel.frame = CGRectMake(30, 60, 260, height);
        self.scrollView.contentSize = CGSizeMake(320, height + 100);
    }
}

//  label自适应高度
- (CGFloat)heightOfLabelFromString:(NSString *)text
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGSize size1 = [text boundingRectWithSize:CGSizeMake(280, 0) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    return size1.height;
}
#pragma mark -时间戳时间转化
- (NSString *)timeTranslate:(NSString *)time
{
    //  将时间戳转化为时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm"];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *dateString = [formatter stringFromDate:date1];
    return dateString;
}

@end
