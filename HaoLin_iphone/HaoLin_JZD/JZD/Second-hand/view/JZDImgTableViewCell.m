//
//  JZDImgTableViewCell.m
//  HaoLin
//
//  Created by Zidon on 14-9-9.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "JZDImgTableViewCell.h"

@implementation JZDImgTableViewCell
@synthesize item=_item;
- (void)awakeFromNib
{
    // Initialization code
//    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    [MBProgressHUD showHUDAddedTo:win animated:YES];
    arr=[[NSMutableArray alloc] init];
}

-(JZDItem *)item
{
    return _item;
}

-(void)setItem:(JZDItem *)item
{
    _item=item;
    [self picArray];
}

-(void)setPicArray:(NSArray *)picArray
{
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    if (!picArray.count) {
        [MBProgressHUD hideHUDForView:win animated:YES];
    }
    JZDModuleHttpRequest *request=[JZDModuleHttpRequest sharedInstace];
    _picArray=picArray;
    for(int i=0;i<_picArray.count;i++){
        [request getImageUrl:_picArray[i] withImage:^(UIImage *img) {
            [arr addObject:img];
            if (i==0) {
                [_imgBtnOne setBackgroundImage:img forState:UIControlStateNormal];
            }else if (i==1){
                [_imgBtnTwo setBackgroundImage:img forState:UIControlStateNormal];
            }else{
                [_imgBtnThree setBackgroundImage:img forState:UIControlStateNormal];
            }
            if (arr.count==_picArray.count) {
                [MBProgressHUD hideHUDForView:win animated:YES];
                [self setNeedsDisplay];
            }
        }];
    }
}

- (IBAction)clickImage:(UIButton *)sender {
    if (!sender.currentBackgroundImage) {
        return;
    }
    for(int i=0;i<arr.count;i++){
        if ([arr[i] isEqual:sender.currentBackgroundImage]) {
            [self makeScrollImage:i];
        }
    }
}

-(void)makeScrollImage:(NSInteger)tag
{
    JZD_loopView *photo=[[JZD_loopView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height )];
    UIWindow *win=[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    photo.backgroundColor=[UIColor blackColor];
    photo.currentPageIndex=tag;
    NSMutableArray *mutable=[@[] mutableCopy];
    for(int i=0;i<_picArray.count;i++){
        JZDImageView *img=[[JZDImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        img.image=arr[i];
        [mutable addObject:img];
    }
    
    photo.blockView=^UIView *(int number){
        return mutable[number];
    };
    photo.blockNum=^NSInteger(void){
        return _picArray.count;
    };
    __weak JZD_loopView *cePhoto=photo;
    photo.tapCountIndex=^(int index){
        [cePhoto removeFromSuperview];
    };
    [win addSubview:photo];
}

@end
