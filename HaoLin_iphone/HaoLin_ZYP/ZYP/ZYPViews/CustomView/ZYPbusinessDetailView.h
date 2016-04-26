//
//  ZYPbusinessDetailView.h
//  HaoLin
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYPBusinessDetailVC;
@interface ZYPbusinessDetailView : UIView<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *goodsDescTextView;
@property (weak, nonatomic) IBOutlet UITextView *businessActivityTV;
@property (nonatomic, strong)ZYPBusinessDetailVC *detailVC;
@end
