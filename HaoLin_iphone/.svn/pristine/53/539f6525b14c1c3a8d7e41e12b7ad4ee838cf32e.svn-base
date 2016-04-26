//
//  SecListTableViewCell.m
//  HaoLin
//
//  Created by Zidon on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "SecListTableViewCell.h"

@implementation SecListTableViewCell
@synthesize item=_item;
- (void)awakeFromNib
{
    // Initialization code
}

-(JZDItem *)item
{
    return _item;
}

-(void)setItem:(JZDItem *)item
{
    _item=item;
    self.needTitle.text=_item.used_title;
    self.needPrice.text=[NSString stringWithFormat:@"%@元",_item.used_price];
//    JZDModuleHttpRequest *request=[JZDModuleHttpRequest sharedInstace];
//    __weak typeof(self) wself=self;
//    [request getImageUrl:item.headImageUrl withImage:^(UIImage *img) {
//        _headImageView.image=img;
//    }];
    self.headImageView.image=_item.headImage;
    self.publishTime.text=_item.used_addtime;
    if (_item.disTance==1.0) {
        self.farWay.text=@"未知";
    }else{
        self.farWay.text=[NSString stringWithFormat:@"%.2fkm",item.disTance];
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
