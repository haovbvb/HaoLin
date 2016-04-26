//
//  MDLDDnrView.h
//  HAOLINAPP
//
//  Created by apple on 14-8-11.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDLCellView : UIView
{

}
/**
 * bjimageview:背景图片
 * NumberLable:商品数量
 * Jianbtn    :减少按钮
 * Addbtn     :增加按钮
 * PriceLable :价格
 * NameLable  :商品名称
 * xuandingbtn:选定按钮
 * changepricebtn:修改价格按钮
 */

@property (weak, nonatomic) IBOutlet UIImageView  *bjimageview;
@property (weak, nonatomic) IBOutlet UILabel      *NumberLable;
@property (weak, nonatomic) IBOutlet UIButton     *Jianbtn;
@property (weak, nonatomic) IBOutlet UIButton     *Addbtn;
@property (weak, nonatomic) IBOutlet UILabel      *PriceLable;
@property (weak, nonatomic) IBOutlet UILabel      *NameLable;
@property (weak, nonatomic) IBOutlet UIButton     *xuandingbtn;
@property (weak, nonatomic) IBOutlet UIButton     *changepricebtn;
@property (nonatomic, assign)int     count;

@end
