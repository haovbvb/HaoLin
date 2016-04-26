//
//  MQLCellOfSection1InShiWuConfirmTableView.m
//  HaoLin
//
//  Created by MQL on 14-9-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCellOfSection1InShiWuConfirmTableView.h"

@interface MQLCellOfSection1InShiWuConfirmTableView ()

@property (nonatomic, weak) IBOutlet UIButton *goodsSelectedBtn;
@property (nonatomic, weak) IBOutlet UIButton *goodsNoSelectedBtn;
@property (nonatomic, weak) IBOutlet UILabel *goods_nameLab;
@property (nonatomic, weak) IBOutlet UILabel *goods_priceLab;
@property (nonatomic, weak) IBOutlet UIImageView *goodSelectedBG;
@property (nonatomic, weak) IBOutlet UIImageView *goodNoSelectedBG;
@property (nonatomic, weak) IBOutlet UIButton *decBtn;
@property (nonatomic, weak) IBOutlet UIButton *incBtn;
@property (nonatomic, weak) IBOutlet UILabel *goods_numLab;
@property (nonatomic, weak) IBOutlet UIView *bottomLine;

-(IBAction)goodsSelectedBtnClicked:(id)sender;
-(IBAction)goodsNoSelectedBtnClicked:(id)sender;
-(IBAction)decBtnClicked:(id)sender;
-(IBAction)incBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  初始化控件内容
 */
-(void)initializeControlContent;


@end

@implementation MQLCellOfSection1InShiWuConfirmTableView

- (void)awakeFromNib
{
    // Initialization code
    [self customInitialization];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setGoodItemInfo:(MQLGoodItemInfo *)goodItemInfo
{
    _goodItemInfo = goodItemInfo;
    
    //初始化控件内容
    [self initializeControlContent];
    
}

-(void)setIsLastIndex:(BOOL)isLastIndex
{
    _isLastIndex = isLastIndex;
    
    if (!self.isLastIndex) {
        
        self.bottomLine.hidden = NO;
        self.bottomLine.backgroundColor = BGColor;
        
    }else{
        
        self.bottomLine.hidden = YES;
    }
}

#pragma mark -- MQLCellOfSection1InShiWuConfirmTableView函数扩展
-(IBAction)goodsSelectedBtnClicked:(id)sender
{
    self.goodsNoSelectedBtn.hidden = NO;
    self.goodsSelectedBtn.hidden = YES;
    
    self.goodSelectedBG.hidden = YES;
    self.goodNoSelectedBG.hidden = NO;
    
    self.goodItemInfo.isSelected = NO;
    if ([self.delegate respondsToSelector:@selector(goodItemInfoChanged)]) {
        
        [self.delegate goodItemInfoChanged];
    }
}

-(IBAction)goodsNoSelectedBtnClicked:(id)sender
{
    self.goodsNoSelectedBtn.hidden = YES;
    self.goodsSelectedBtn.hidden = NO;
    
    self.goodSelectedBG.hidden = NO;
    self.goodNoSelectedBG.hidden = YES;
    
    self.goodItemInfo.isSelected = YES;
    if ([self.delegate respondsToSelector:@selector(goodItemInfoChanged)]) {
        
        [self.delegate goodItemInfoChanged];
    }
}

-(IBAction)decBtnClicked:(id)sender
{
    if (self.goodItemInfo.isSelected) {
        
        int goods_num = self.goodItemInfo.goods_num.intValue;
        goods_num--;
        
        if (goods_num > 0) {
            
            self.goodItemInfo.goods_num = [NSString stringWithFormat:@"%d", goods_num];
            self.goods_numLab.text = self.goodItemInfo.goods_num;
            
            if ([self.delegate respondsToSelector:@selector(goodItemInfoChanged)]) {
                
                [self.delegate goodItemInfoChanged];
            }
            
        }
    }

}

-(IBAction)incBtnClicked:(id)sender
{
    if (self.goodItemInfo.isSelected) {
        
        int goods_num = self.goodItemInfo.goods_num.intValue;
        goods_num++;
        
        self.goodItemInfo.goods_num = [NSString stringWithFormat:@"%d", goods_num];
        self.goods_numLab.text = self.goodItemInfo.goods_num;
        
        if ([self.delegate respondsToSelector:@selector(goodItemInfoChanged)]) {
            
            [self.delegate goodItemInfoChanged];
        }
        
    }

}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    
}

/**
 *  初始化控件内容
 */
-(void)initializeControlContent
{
    if (self.goodItemInfo.isSelected) {
        
        self.goodsNoSelectedBtn.hidden = YES;
        self.goodsSelectedBtn.hidden = NO;
        
    }else{
        
        self.goodsNoSelectedBtn.hidden = NO;
        self.goodsSelectedBtn.hidden = YES;
        
    }
    
    self.goods_nameLab.text = self.goodItemInfo.goods_name;
    self.goods_priceLab.text = [NSString stringWithFormat:@"￥%@", self.goodItemInfo.goods_price];
    
    if (self.goodItemInfo.isSelected) {
        
        self.goodSelectedBG.hidden = NO;
        self.goodNoSelectedBG.hidden = YES;
        
    }else{
        
        self.goodSelectedBG.hidden = YES;
        self.goodNoSelectedBG.hidden = NO;
    }
    
    self.goods_numLab.text = self.goodItemInfo.goods_num;
}

@end
