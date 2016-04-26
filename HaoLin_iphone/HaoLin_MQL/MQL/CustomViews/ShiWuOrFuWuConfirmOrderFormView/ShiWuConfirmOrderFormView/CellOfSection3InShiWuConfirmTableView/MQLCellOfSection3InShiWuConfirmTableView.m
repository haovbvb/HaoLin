//
//  MQLCellOfSection3InShiWuConfirmTableView.m
//  HaoLin
//
//  Created by MQL on 14-9-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLCellOfSection3InShiWuConfirmTableView.h"

@interface MQLCellOfSection3InShiWuConfirmTableView ()

@property (nonatomic, weak) IBOutlet UIButton *payModeSelectedBtn;
@property (nonatomic, weak) IBOutlet UIButton *payModeNoSelectedBtn;
@property (nonatomic, weak) IBOutlet UILabel *payModeNameLab;
@property (nonatomic, weak) IBOutlet UIView *bottomLine;

-(IBAction)payModeSelectedBtnClicked:(id)sender;
-(IBAction)payModeNoSelectedBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  初始化控件内容
 */
-(void)initializeControlContent;

@end

@implementation MQLCellOfSection3InShiWuConfirmTableView

-(void)dealloc
{
    [_payModeItemInfo removeObserver:self forKeyPath:@"isSelected"];
}

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

-(void)setPayModeDataManage:(MQLPayModeDataManage *)payModeDataManage
{
    _payModeDataManage = payModeDataManage;
    
}

-(void)setPayModeItemInfo:(MQLPayModeItemInfo *)payModeItemInfo
{
    if (_payModeItemInfo) {
        
        //先移除先前对象的kvo
        [_payModeItemInfo removeObserver:self forKeyPath:@"isSelected"];

    }
    
    //添加当前对象的kvo
    [payModeItemInfo addObserver:self forKeyPath:@"isSelected" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionNew context:nil];
    
    _payModeItemInfo = payModeItemInfo;
    
    //初始化控件内容
    [self initializeControlContent];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    if ([keyPath isEqual:@"isSelected"]) {
        
        [self initializeControlContent];
    }
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

#pragma mark -- MQLCellOfSection3InShiWuConfirmTableView函数扩展

-(IBAction)payModeSelectedBtnClicked:(id)sender
{
    //当变成多选时，打开下面注释
    /*
    self.payModeNoSelectedBtn.hidden = NO;
    self.payModeSelectedBtn.hidden = YES;
    
    self.payModeItemInfo.isSelected = NO;
     */
}

-(IBAction)payModeNoSelectedBtnClicked:(id)sender
{
    //当变成多选时，打开下面注释
    /*
    self.payModeNoSelectedBtn.hidden = YES;
    self.payModeSelectedBtn.hidden = NO;
     */
    
    [self.payModeDataManage cancelSelectedItem];
    self.payModeItemInfo.isSelected = YES;
    
    if ([self.delegate respondsToSelector:@selector(selectedByUser)]) {
        
        [self.delegate selectedByUser];
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
    if (self.payModeItemInfo.isSelected) {
        
        self.payModeNoSelectedBtn.hidden = YES;
        self.payModeSelectedBtn.hidden = NO;
        
    }else{
        
        self.payModeNoSelectedBtn.hidden = NO;
        self.payModeSelectedBtn.hidden = YES;
    }
    
    self.payModeNameLab.text = self.payModeItemInfo.payModeName;
}

@end
