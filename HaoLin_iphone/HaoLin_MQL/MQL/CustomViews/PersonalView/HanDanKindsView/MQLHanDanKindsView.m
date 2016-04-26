//
//  MQLHanDanKindsView.m
//  HaoLin
//
//  Created by mac on 14-8-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLHanDanKindsView.h"

@interface MQLHanDanKindsView ()<UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *arrayOfHanDanKinds;      //喊单种类数组
@property (nonatomic, strong) NSDictionary *selectedHanDankind; //选中的喊单分类

/**
 *  自定义初始化
 */
-(void)customInitialization;

-(IBAction)HanDanKindsBtnClicked:(id)sender;


@end

@implementation MQLHanDanKindsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    //自定义初始化
    [self customInitialization];
    
}

#pragma mark -- MQLHanDanKindsView函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"HanDanKinds" ofType:@"plist"];
    self.arrayOfHanDanKinds = [[NSArray alloc]initWithContentsOfFile:path];
}

-(IBAction)HanDanKindsBtnClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    NSUInteger tag = btn.tag;
    
    //先判断是二手物品吗？
    if (tag == 1005) {
        
        NSLog(@"进入二手物品");
        JZDSec_handViewController *secHand=[[JZDSec_handViewController alloc] initWithNibName:@"JZDSec_handViewController" bundle:nil];
        JZDNavgationViewController *nav=[[JZDNavgationViewController alloc] initWithNavigationBarClass:[JZDNavgationBar class] toolbarClass:nil];
        nav.viewControllers=@[secHand];
        [self.ownerViewController presentViewController:nav animated:YES completion:^{
            
        }];
        return;
    }else if(tag == 1012){
        
        NSLog(@"进入聚会");
         HSPPartyViewController *party = [[HSPPartyViewController alloc] initWithNibName:@"HSPPartyViewController" bundle:nil];
        [_ownerViewController presentViewController:party animated:YES completion:nil];
        
        return;
    }else if(tag == 1013){
        
        NSLog(@"进入宠物");
        JZDPetsAddViewController *padd=[[JZDPetsAddViewController alloc] initWithNibName:@"JZDPetsAddViewController" bundle:nil];
        [self.ownerViewController presentViewController:padd animated:YES completion:^{
            
        }];
        
        return;
    }
    
    for (NSDictionary *item in self.arrayOfHanDanKinds) {
        
        if ([[item objectForKey:@"kindTag"]integerValue] == tag) {
            
            self.selectedHanDankind = item;
            break;
        }
    }
    
    if ([self.selectedHanDankind objectForKey:@"childs"]) {
        
        int count = [(NSArray *)[self.selectedHanDankind objectForKey:@"childs"]count];
        
        if (count == 2) {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:[self.selectedHanDankind objectForKey:@"kindTitle"]
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"发往农村", @"发往城镇",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self];
        }else{
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:[self.selectedHanDankind objectForKey:@"kindTitle"]
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"水/电/暖", @"门窗", @"防水补漏", @"卫浴/厨房", nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self];
        }

        
    }else{
        
        //显示文字或语音喊单视图CharacterOrAudioHanDanViewController
        MQLCharacterOrAudioHanDanViewController *vc = [[MQLCharacterOrAudioHanDanViewController alloc]initWithNibName:@"MQLCharacterOrAudioHanDanViewController" bundle:nil];
        vc.selectedHanDankind = self.selectedHanDankind;
        [self.ownerViewController.navigationController pushViewController:vc animated:YES];
    }
    
    

    
}

#pragma mark -- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index = %d", buttonIndex);
    if (buttonIndex >= [(NSArray *)[self.selectedHanDankind objectForKey:@"childs"]count]) {
        return;
    }
    
    
    NSDictionary *selectedHanDankind = [[self.selectedHanDankind objectForKey:@"childs"]objectAtIndex:buttonIndex];
    
    
    //显示文字或语音喊单视图CharacterOrAudioHanDanViewController
    MQLCharacterOrAudioHanDanViewController *vc = [[MQLCharacterOrAudioHanDanViewController alloc]initWithNibName:@"MQLCharacterOrAudioHanDanViewController" bundle:nil];
    vc.selectedHanDankind = selectedHanDankind;
    [self.ownerViewController.navigationController pushViewController:vc animated:YES];

}






@end
