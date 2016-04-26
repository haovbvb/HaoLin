//
//  MDLQDMapView.h
//  HaoLin
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MDLQDMapView : UIView
{
    NSString*  precisionString1,*dimensionString1;
    NSString*  tietletext;
    NSMutableArray *  axdic;
    NSString*  address;
 }
@property (weak, nonatomic) IBOutlet UIButton *mapbackbtn;
@property (weak, nonatomic) IBOutlet UIView   *mapnavbar;
@property (weak, nonatomic) IBOutlet UILabel  *maptitleLable;
//@property (nonatomic,strong) NSString *  precisionString1;
//@property (nonatomic,strong) NSString *  dimensionString1;
@property (nonatomic,strong) MDLMapViewController* mapVC;

@end
