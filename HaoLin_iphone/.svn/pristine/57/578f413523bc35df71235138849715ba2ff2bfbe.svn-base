//
//  ZYPPictureDescVC.m
//  HaoLin
//
//  Created by mac on 14-9-12.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPPictureDescVC.h"
#define topHeight 10
@interface ZYPPictureDescVC ()
{
    BOOL state;
    UIImagePickerController *imagePicker;
    NSInteger count;
    ZYPAddImageView *addView1;
}
@property (nonatomic, strong)NSMutableArray *imagesArray;
@property (nonatomic, strong)NSMutableArray *viewArray;
@property (nonatomic, strong)NSMutableArray *neImagesArray;
@end

@implementation ZYPPictureDescVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//  编辑按钮的操作
- (IBAction)edit:(id)sender
{
    if (state == YES)
    {
        [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        for (int i = 0; i < self.viewArray.count; i ++) {
            ZYPAddImageView *addView = [self.viewArray objectAtIndex:i];
            addView.deleBTn.hidden = NO;
            if (i + 1 == self.viewArray.count)  {
                addView.deleBTn.hidden = YES;
            }
        }
        state = NO;
    }else if (state == NO)
    {
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        for (int i = 0; i < self.viewArray.count; i ++) {
            ZYPAddImageView *addView = [self.viewArray objectAtIndex:i];
            addView.deleBTn.hidden = YES;
            if (i + 1 == self.viewArray.count)  {
                addView.deleBTn.hidden = YES;
            }
        }
        state = YES;
    }

}
//  返回按钮
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//  从前个界面传过来的数据，上传图片后重新刷新tableView
- (void)conductHere:(NSMutableArray *)array
{
    for (int i = 0; i <array.count; i ++)
    {
        ZYPPictureDescObject *object = [array objectAtIndex:i];
        ZYPAddImageView *addV1 = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddImageView" owner:self options:nil] lastObject];
        addV1.owerViewController = self;
        addV1.frame = CGRectMake(60, topHeight + 160 * i, 200, 160);
        [addV1.addImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",object.thumb]] placeholderImage:[UIImage imageNamed:@"ZYPshop_default_avatar.png"]];
        [self.viewArray insertObject:addV1 atIndex:0];
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    if (IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
    }else
    {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    self.titleLabel.backgroundColor = ZYPBGColor;

    state = YES;
    self.imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.viewArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.neImagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view from its nib.
    count = -1;
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    // 全局add
    addView1 = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddImageView" owner:self options:nil] lastObject];
    addView1.owerViewController = self;
    addView1.addImageView.userInteractionEnabled = YES;
        [self.viewArray addObject:addView1];
    NSLog(@"%@",self.requstImageArray);
    [self conductHere:self.requstImageArray];

}
//  添加图片（手势方法）
- (void)addImage
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选择图片源" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相册",@"拍照", nil];
    [alertView show];
}
- (void)deleteImage:(NSInteger )tag
{
    //  判断删除的是从本地删除，还是从服务器删除
    if (tag < self.neImagesArray.count)
    {
    [self.neImagesArray removeObjectAtIndex:tag];
    [self.viewArray removeObjectAtIndex:tag];
    }else if (tag >= self.neImagesArray.count)
    {
    //  删除操作
    [self.viewArray removeObjectAtIndex:tag];
    [self delete1:[self.requstImageArray objectAtIndex:tag]];
    [self.requstImageArray removeObjectAtIndex:tag];
    }
    [self.tableView reloadData];
}
//  删除图片
- (void)delete1:(ZYPPictureDescObject *)object
{
    HSPAccount *accout = [HSPAccountTool account];

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&photo_ids=%@",deleteImageUrl,accout.user_id,accout.userTokenid,object.photo_id];
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         NSDictionary *dic  = respondObject;
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             [self alertWithMessage:[dic objectForKey:@"message"]];
         }else
         {
             //  删除失败提示
             [self alertWithMessage:@"删除失败"];
         }
    }];
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
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }else if (buttonIndex == 2)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    
}
#pragma mark - 图片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    count ++;
    [self setImageOnImageView:image];
    
}
//  添加图片
- (void)setImageOnImageView:(UIImage *)image
{
    
    [addView1 removeFromSuperview];
    ZYPAddImageView *addView = [[[NSBundle mainBundle] loadNibNamed:@"ZYPAddImageView" owner:self options:nil] lastObject];
    addView.frame = CGRectMake(60,topHeight + 160 *count,200, 160);
    addView.addImageView.image = image;
    addView.owerViewController = self;
    //  这两个操作必须一样证才能保证再删除的时候他们具有相同的tag值
    [self.neImagesArray insertObject:addView atIndex:0];
    [self.viewArray insertObject:addView atIndex:0];
    if (self.viewArray.count == 4)
    {
        addView1.hidden = YES;
    }
    [self.tableView reloadData];
}

//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - tableiew 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 540;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifie";
  ZYPTableViewCell *  cell1 = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell1 == nil) {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:@"ZYPTableViewCell" owner:self options:nil] lastObject];
    }
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.viewArray count] == 1) {
        ZYPAddImageView *addViEW = [self.viewArray objectAtIndex:0];
        addViEW.frame = CGRectMake(60, topHeight, 200, 160);
        addViEW.owerViewController = self;
        addViEW.addImageView.userInteractionEnabled = YES;
        [cell1.contentView addSubview:addViEW];
    }else if ([self.viewArray count] <= 4)
    {
        for (int i = 0; i < self.neImagesArray.count; i ++)
        {
            ZYPAddImageView *imageView = [self.neImagesArray objectAtIndex:i];
            imageView.tag = i;
        }
        for (int i = 0; i < self.viewArray.count; i ++) {
            ZYPAddImageView *addView = [self.viewArray objectAtIndex:i];
            if (i + 1 == self.viewArray.count) {
                addView.addImageView.userInteractionEnabled = YES;
                if (self.viewArray.count == 4) {
                    addView.hidden = YES;
                }else
                {
                    addView.hidden = NO;
                }
            }else
            {
                addView.addImageView.userInteractionEnabled = NO;
            }
            addView.frame = CGRectMake(60, topHeight + 160 * i + 10, 200, 160);
            addView.tag = i;
            [cell1.contentView addSubview:addView];
        }
    }
    return cell1;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *customeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 10, 120, 40);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commitPicture:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [customeView addSubview:btn];
    return customeView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}
- (void)commitPicture:(UIButton *)btn
{
    if (self.neImagesArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲,您还没有选择图片哦" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if (self.viewArray.count <= 4 && self.neImagesArray.count > 0)
    {
                   //  清除原先的数据
            [self.imagesArray removeAllObjects];
            [self.requstImageArray removeAllObjects];
            for (int i = 0; i < self.neImagesArray.count; i ++)
            {
                ZYPAddImageView *addImagView = [self.neImagesArray objectAtIndex:i];
                [self.imagesArray addObject:addImagView.addImageView.image];
            }
            NSLog(@"image  %d",self.imagesArray.count);
        [self uploadPicture:self.imagesArray];
    }
}
//  上传图片
- (void)uploadPicture:(NSMutableArray *)array
{
   
    NSArray *nameArray = [NSArray arrayWithObjects:@"pic_1",@"pic_2",@"pic_3", nil];
    HSPAccount *accout = [HSPAccountTool account];

    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@",addImageUrl];
    NSDictionary *paraDic;
    NSArray *uploadArr;
    switch (self.imagesArray.count) {
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
    
    __weak ZYPPictureDescVC *descVC = self;
    [manger businessUPload:array filedLetter:uploadArr urlString:urlString para:paraDic completion:^(id responedObject)
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
                    [descVC.requstImageArray addObject:descObj];
                }
                if (descVC.requstImageArray.count > 0)
                {
                    NSRange range;
                    range.location = 0;
                    range.length = self.viewArray.count - 1;
                    [self.viewArray removeObjectsInRange:range];
                    [self.neImagesArray removeAllObjects];
                }
                [descVC conductHere:descVC.requstImageArray];
            }else
            {
                //  上传失败提示
                [descVC alertWithMessage:[dic objectForKey:@"message"]];
            }
        }else
        {
            [descVC alertWithMessage:@"图片上传失败"];
        }
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
