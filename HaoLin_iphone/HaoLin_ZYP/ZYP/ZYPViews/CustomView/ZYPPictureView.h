//
//  ZYPPictureView.h
//  HaoLin
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import <UIKit/UIKit.h>



@class ZYPPictureViewController;
@interface ZYPPictureView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *imagePicker;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, strong)NSMutableArray *conductAraayF;
@property (nonatomic, strong)ZYPPictureViewController *pictureVC;

@end
