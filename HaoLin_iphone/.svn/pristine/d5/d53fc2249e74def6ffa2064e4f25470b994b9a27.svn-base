//
//  ZYPPictureView.m
//  HaoLin
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPPictureView.h"
@interface ZYPPictureView ()
{
    NSInteger indexTag;
}
@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic, strong)NSMutableArray *sourceArray;
@end
@implementation ZYPPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib
{
    self.imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.sourceArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.titleLabel.backgroundColor = ZYPBGColor;
    if (IS_IPHONE_5) {
        self.frame = CGRectMake(0, 0, 320, 568);
        self.tableView.frame = CGRectMake(0, 64, 320, 464);
        self.commitBtn.frame = CGRectMake(0, 528, 320, 40);
    }else
    {
        self.frame = CGRectMake(0, 0, 320, 480);
        self.tableView.frame = CGRectMake(0, 64, 320, 376);
        self.commitBtn.frame = CGRectMake(0, 440, 320, 40);
    }
}
/**
 *  tableview代理方法
 *
 */
// 定义headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.font = [UIFont systemFontOfSize:chacterHong];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"亲,最多添加三张照片，可滑动删除哦";
        label.textColor = [UIColor orangeColor];
        [customView addSubview:label];
        return customView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageArray.count + self.conductAraayF.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.conductAraayF.count + self.imageArray.count == 3) {
        
        if (indexPath.row == 3) {
            return 0;
        }
    }
    return 400.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"reuse";
    ZYPPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZYPPictureCell" owner:self options:nil] lastObject];
    }
    if (self.imageArray.count + self.conductAraayF.count < 4)
    {
        if (self.imageArray.count + self.conductAraayF.count == 0)
        {
            cell.addImageView.image = [UIImage imageNamed:@"ZYPAdd@2x.png"];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addimage:)];
            cell.addImageView.userInteractionEnabled = YES;
            [cell.addImageView addGestureRecognizer:tap];
            return cell;
        }else if (self.imageArray.count + self.conductAraayF.count == 1)
        {
            if (indexPath.row < self.imageArray.count) {
                UIImage *iamge = [self.imageArray objectAtIndex:indexPath.row];
                cell.addImageView.image = iamge;
                cell.addImageView.userInteractionEnabled = NO;
                return cell;
            }else if (indexPath.row >= self.imageArray.count && indexPath.row != 1)
            {
                    NSInteger index = indexPath.row - self.imageArray.count;
                    ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:index];
                    [cell.addImageView setImageWithURL:[NSURL URLWithString:object.y_thumb] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
                cell.addImageView.userInteractionEnabled = NO;
                    return cell;
            }else if (indexPath.row == 1)
            {
                cell.addImageView.image = [UIImage imageNamed:@"ZYPAdd@2x.png"];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addimage:)];
                cell.addImageView.userInteractionEnabled = YES;
                [cell.addImageView addGestureRecognizer:tap];

                return cell;
            }
        }else if (self.imageArray.count + self.conductAraayF.count == 2)
        {
            if (indexPath.row < self.imageArray.count) {
                UIImage *iamge = [self.imageArray objectAtIndex:indexPath.row];
                cell.addImageView.image = iamge;
                cell.addImageView.userInteractionEnabled = NO;
                return cell;
            }else if (indexPath.row >= self.imageArray.count && indexPath.row != 2)
            {
                NSInteger index = indexPath.row - self.imageArray.count;
                ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:index];
                [cell.addImageView setImageWithURL:[NSURL URLWithString:object.y_thumb] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
                cell.addImageView.userInteractionEnabled = NO;
                return cell;
            }else if (indexPath.row == 2)
            {
                cell.addImageView.image = [UIImage imageNamed:@"ZYPAdd@2x.png"];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addimage:)];
                cell.addImageView.userInteractionEnabled = YES;
                [cell.addImageView addGestureRecognizer:tap];

                return cell;
            }
        }else if (self.imageArray.count + self.conductAraayF.count == 3)
        {
            if (indexPath.row < self.imageArray.count) {
                UIImage *iamge = [self.imageArray objectAtIndex:indexPath.row];
                cell.addImageView.image = iamge;
                cell.addImageView.userInteractionEnabled = NO;
                return cell;
            }else if (indexPath.row >= self.imageArray.count && indexPath.row != 3)
            {
                NSInteger index = indexPath.row - self.imageArray.count;
                ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:index];
                cell.addImageView.userInteractionEnabled = NO;
                [cell.addImageView setImageWithURL:[NSURL URLWithString:object.y_thumb] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
                return cell;
            }else if (indexPath.row == 3)
            {
                return cell;
            }
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        indexTag = indexPath.row;
        /**
         *  从服务器删除
         */
        if (self.imageArray.count == 0)
        {
            ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:indexPath.row];
            [self delete1:object addiamgeView:nil];
//            [self.conductAraayF removeObjectAtIndex:indexPath.row];

        }else if (self.imageArray.count == 1)
        {
            if (indexPath.row < 1)
            {
                [self.imageArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:indexPath.row];
                [self delete1:object addiamgeView:nil];
            }else if (indexPath.row >= 1)
            {
//                ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:indexPath.row];
//                [self delete1:object addiamgeView:nil];
//                [self.conductAraayF removeObjectAtIndex:indexPath.row];
            }
        }else if (self.imageArray.count == 2)
        {
            if (indexPath.row < 2) {
                [self.imageArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:indexPath.row];
                [self delete1:object addiamgeView:nil];

            }else if (indexPath.row >= 2)
            {
//                ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:indexPath.row];
//                [self delete1:object addiamgeView:nil];
//                [self.conductAraayF removeObjectAtIndex:indexPath.row];
            }
        }else if (self.imageArray.count == 3)
        {
            [self.imageArray removeObjectAtIndex:indexPath.row];
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            ZYPPictureDescObject *object = [self.conductAraayF objectAtIndex:indexPath.row];
            [self delete1:object addiamgeView:nil];
        }
       
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.imageArray.count + self.conductAraayF.count == 0) {
        if (indexPath.row == 0) {
            return NO;
        }
    }else if (self.imageArray.count + self.conductAraayF.count == 1)
    {
        if (indexPath.row == 1) {
            return NO;
        }else
        {
            return YES;
        }
    }else if (self.imageArray.count + self.conductAraayF.count == 2)
    {
        if (indexPath.row == 2) {
            return NO;
        }else
        {
            return YES;
        }
    }else if (self.imageArray.count + self.conductAraayF.count == 3)
    {
        
    return YES;
        
    }
    return NO;
}
//  删除图片
- (void)delete1:(ZYPPictureDescObject *)object addiamgeView:(ZYPAddImageView *)imageview
{
    NSLog(@"delete1 = %@",object.photo_id);
    __weak ZYPPictureView *descVC = self;
    HSPAccount *accout = [HSPAccountTool account];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&photo_ids=%@",deleteImageUrl,accout.user_id,accout.userTokenid,object.photo_id];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         if ([respondObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *dic  = respondObject;
             if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
                 [descVC alertWithMessage:[dic objectForKey:@"message"]];
                 [descVC.conductAraayF removeObjectAtIndex:indexTag];
                 [descVC.tableView reloadData];
             }else
             {
                 //  删除失败提示
                 [descVC alertWithMessage:[dic objectForKey:@"message"]];
//                 [descVC.conductAraayF removeObjectAtIndex:indexTag];
                 [descVC.tableView reloadData];
             }
         }else
         {
             [descVC alertWithMessage:@"网络断开"];
//             [descVC.conductAraayF removeObjectAtIndex:indexTag];
             [descVC.tableView reloadData];
         }
        }];
}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)back:(id)sender
{
    [self.pictureVC.navigationController popViewControllerAnimated:YES];
}
- (IBAction)edit:(id)sender
{
    
}
- (IBAction)commit:(id)sender
{
    if (self.imageArray.count > 0)
    {
        [self.conductAraayF removeAllObjects];
        //  上传图片
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        NSArray *nameArray = [NSArray arrayWithObjects:@"pic_1",@"pic_2",@"pic_3", nil];
        HSPAccount *accout = [HSPAccountTool account];
        
        ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
        NSString *urlString = [NSString stringWithFormat:@"%@",addImageUrl];
        NSDictionary *paraDic;
        NSArray *uploadArr;
        switch (self.imageArray.count) {
            case 1:
                paraDic = [NSDictionary dictionaryWithObjectsAndKeys:[nameArray objectAtIndex:0],@"pic_1",accout.user_id,@"user_id",accout.userTokenid,@"tokenid", nil];
                uploadArr = [NSArray arrayWithObjects:@"pic_1", nil];
                break;
            case 2:
                paraDic = [NSDictionary dictionaryWithObjectsAndKeys:[nameArray objectAtIndex:0],@"pic_1",[nameArray objectAtIndex:1],@"pic_2",accout.user_id,@"user_id",accout.userTokenid,@"tokenid", nil];
                uploadArr = [NSArray arrayWithObjects:@"pic_1",@"pic_2", nil];
                break;
            case 3:
                paraDic = [NSDictionary dictionaryWithObjectsAndKeys:[nameArray objectAtIndex:0],@"pic_1",[nameArray objectAtIndex:1],@"pic_2",[nameArray objectAtIndex:2],@"pic_3",accout.user_id,@"user_id",accout.userTokenid,@"tokenid", nil];
                uploadArr = [NSArray arrayWithObjects:@"pic_1",@"pic_2",@"pic_3", nil];
                break;
            default:
                break;
        }
        
        __weak ZYPPictureView *descVC = self;
        [manger businessUPload:self.imageArray filedLetter:uploadArr urlString:urlString para:paraDic completion:^(id responedObject)
         {
             if ([responedObject isKindOfClass:[NSDictionary class]])
             {
                 NSDictionary *dic = responedObject;
                 if ([[dic objectForKey:@"code"] isEqualToString:@"0"])
                 {
                     //  显示添加成功提示框
                     [descVC alertWithMessage:[dic objectForKey:@"message"]];
                     NSArray *photoArray = [dic objectForKey:@"data"];
                     for (NSDictionary *dic1 in photoArray)
                     {
                         ZYPPictureDescObject *descObj = [[ZYPPictureDescObject alloc] initPictureDescObjectWithDic:dic1];
                         [descVC.conductAraayF addObject:descObj];
                     }
                     [MBProgressHUD hideAllHUDsForView:descVC.tableView animated:YES];
                     [descVC.imageArray removeAllObjects];
                     [descVC.tableView reloadData];
                 }else
                 {
                     [MBProgressHUD hideAllHUDsForView:descVC.tableView animated:YES];
                     //  上传失败提示
                     [descVC alertWithMessage:[dic objectForKey:@"message"]];
                 }
             }else
             {
                 [MBProgressHUD hideAllHUDsForView:descVC.tableView animated:YES];
                 [descVC alertWithMessage:@"上传失败，请检查网络连接"];
             }
        }];
    }else
    {
        [self alertWithMessage:@"亲，您还没有选择图片哦"];
    }
    
}
/**
 *  添加照片手势
 *
 *  @param tap 
 */
- (void)addimage:(UITapGestureRecognizer *)tap
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选择图片源" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"拍照", nil];
    [alertView show];
}
#pragma mark - alert代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.navigationController.delegate = self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 1) {
        //  判断相机是否尅一得到
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.pictureVC presentViewController:imagePicker animated:YES completion:nil];
        }
    }else if (buttonIndex == 2)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self.pictureVC presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    
}
#pragma mark - 图片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self.pictureVC dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.pictureVC dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageArray addObject:image];
    [self.tableView reloadData];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
