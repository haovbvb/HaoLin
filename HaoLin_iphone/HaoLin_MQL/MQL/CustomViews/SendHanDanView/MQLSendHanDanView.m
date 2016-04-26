//
//  MQLSendHanDanView.m
//  HaoLin
//
//  Created by maqianli on 14-8-21.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLSendHanDanView.h"

@interface MQLSendHanDanView ()<UITableViewDataSource, UITableViewDelegate, \
                                MQLPushBusinessScopeCellInSendHanDanViewDelegate,
                                MQLConfirmOrAgainCellInSendHanDanViewDelegate,
                                MQLSendAddressCellInSendHanDanViewDelegate,
                                MQLSendAddressInputViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *navView;
@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UILabel *handanTitleLab;
@property (nonatomic, weak) IBOutlet UITableView *contentTableView;

@property (nonatomic, strong) UIView *sendAddressInputViewContainer;
@property (nonatomic, strong) UIView *sendAddressInputViewhalfTransparenceDiTu;
@property (nonatomic, strong) MQLSendAddressInputView *sendAddressInputView;


-(IBAction)backBtnClicked:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag;

/**
 *  注册通知
 NotificationOfPersonalHanDanRequestOver
 */
-(void)registerNotifications;

/**
 *  清空sendAddressInputView相关
 */
-(void)clearSomethingAboutSendAddressInputView;


@end

@implementation MQLSendHanDanView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NotificationOfPersonalHanDanRequestOver object:nil];
}

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

-(void)setOwnerViewController:(UIViewController *)ownerViewController
{
    _ownerViewController = ownerViewController;
    
}

-(void)setSelectedHanDankind:(NSDictionary *)selectedHanDankind
{
    _selectedHanDankind = selectedHanDankind;
    NSString *kindTitle = [selectedHanDankind objectForKey:@"kindTitle"];
    
    self.handanTitleLab.text = [NSString stringWithFormat:@"%@喊单", kindTitle];
}

-(void)setPersonalHanDanDataManage:(MQLPersonalHanDanDataManage *)personalHanDanDataManage
{
    _personalHanDanDataManage = personalHanDanDataManage;
}

/**
 *  刷新contentTableView
 */
-(void)refreshContentTableView
{
    [self.contentTableView reloadData];
    
}

/*
 注册键盘通知事件
 */
-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShown:)
                                                name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShown:)
                                                name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardWillShown:(NSNotification*)notification
{
    
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *value = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [value CGRectValue];
    
    float offset = keyboardFrame.size.height;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:[duration doubleValue]];
    
    self.sendAddressInputView.frame = CGRectMake(self.sendAddressInputView.frame.origin.x,
                                               self.sendAddressInputViewContainer.frame.size.height - offset - self.sendAddressInputView.frame.size.height,
                                               self.sendAddressInputView.frame.size.width,
                                               self.sendAddressInputView.frame.size.height);
    
    [UIView commitAnimations];
    
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:[duration doubleValue]];
    
    self.sendAddressInputView.frame = CGRectMake(
                                                 self.sendAddressInputView.bounds.origin.x,
                                               self.sendAddressInputViewContainer.frame.size.height - self.sendAddressInputView.frame.size.height,
                                               self.sendAddressInputView.bounds.size.width,
                                               self.sendAddressInputView.bounds.size.height);
    
    [UIView commitAnimations];
}


/**
 *  注销键盘通知事件
 */
-(void)resignForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark --MQLSendHanDanView函数扩展

-(IBAction)backBtnClicked:(id)sender
{
    [self.ownerViewController.navigationController popViewControllerAnimated:YES];
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.navView.backgroundColor = BGOrangeColor;
    
    //注册通知
    [self registerNotifications];
    
}


/**
 *  显示提示
 *
 *  @param title
 *  @param msg
 *  @param tag
 */
-(void)showAlertViewWithTitle:(NSString*)title msg:(NSString*)msg tag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

/**
 *  注册通知
 NotificationOfPersonalHanDanRequestOver
 */
-(void)registerNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onReceiveNotificationOfPersonalHanDanRequestOver:) name:NotificationOfPersonalHanDanRequestOver object:nil];
    
}

-(void)onReceiveNotificationOfPersonalHanDanRequestOver:(NSNotification*)notification
{
    NSLog(@"%@", notification.userInfo);
    ViewKind viewkind = [[notification.userInfo objectForKey:@"viewkind"]intValue];
    if (viewkind != ViewKind_SendHanDan) {
        return;
    }
    
    [MBProgressHUD hideHUDForView:self.contentTableView animated:YES];
    
    int code = [[[notification.userInfo objectForKey:@"userInfo"] objectForKey:@"code"]intValue];
    if (code == 0) {
        
        int merchant_num = [[[[notification.userInfo objectForKey:@"userInfo"] objectForKey:@"data"]objectForKey:@"merchant_num"]intValue];
        if (merchant_num > 0) {
            
            //展示等待
            MQLHanDanWaitingViewController *vc = [[MQLHanDanWaitingViewController alloc]initWithNibName:@"MQLHanDanWaitingViewController" bundle:nil];
            vc.selectedHanDankind = self.selectedHanDankind;
            vc.personalHanDanDataManage = self.personalHanDanDataManage;
            vc.dataOfHanDanOver = [[notification.userInfo objectForKey:@"userInfo"] objectForKey:@"data"];
            [self.ownerViewController.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            NSString *msg = @"对不起，没有找到符合您需要的商家。";
            [self showAlertViewWithTitle:@"提示" msg:msg tag:-1];
        }
        

        
    }else{
        
        //提示error
        NSString *msg = [[notification.userInfo objectForKey:@"userInfo"] objectForKey:@"message"];
        [self showAlertViewWithTitle:@"提示" msg:msg tag:-1];
    }
    
    
}

/**
 *  清空sendAddressInputView相关
 */
-(void)clearSomethingAboutSendAddressInputView
{
    //注销键盘通知事件
    [self resignForKeyboardNotifications];
    
    //删除派送地址输入视图容器
    [self.sendAddressInputViewContainer removeFromSuperview];
    self.sendAddressInputViewContainer = nil;
    
    //删除派送地址输入视图半透明底图
    [self.sendAddressInputViewhalfTransparenceDiTu removeFromSuperview];
    self.sendAddressInputViewhalfTransparenceDiTu = nil;
    
    //删除派送地址输入视图
    [self.sendAddressInputView removeFromSuperview];
    self.sendAddressInputView = nil;
}

#pragma mark -- UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (indexPath.row) {
            case 0:
            {
                if (self.personalHanDanDataManage.charaters.length == 0) {
                    
                    NSString *reuseIdentifier = @"reuseIdentifierOfTryListen";
                    MQLTryListenCellInSendHanDanView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                    if (cell == nil) {
                        
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLTryListenCellInSendHanDanView" owner:nil options:nil]lastObject];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.backgroundColor = [UIColor clearColor];
                        
                    }
                    
                    cell.personalHanDanDataManage = self.personalHanDanDataManage;
                    
                    return cell;
                    
                }else{
                    
                    NSString *reuseIdentifier = @"reuseIdentifierOfCharacter";
                    MQLCharacterCellInSendHanDanView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                    if (cell == nil) {
                        
                        cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLCharacterCellInSendHanDanView" owner:nil options:nil]lastObject];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
                    }
                    
                    cell.personalHanDanDataManage = self.personalHanDanDataManage;
                    
                    return cell;
                    
                }
            }
                break;
            case 1:
            {
                NSString *reuseIdentifier = @"reuseIdentifierOfServiceCharge";
                MQLServiceChargeCellInSendHanDanView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                if (cell == nil) {
                    
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLServiceChargeCellInSendHanDanView" owner:nil options:nil]lastObject];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                
                cell.personalHanDanDataManage = self.personalHanDanDataManage;
                
                return cell;
            }
                break;
            case 2:
            {
                NSString *reuseIdentifier = @"reuseIdentifierOfSendAddress";
                MQLSendAddressCellInSendHanDanView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                if (cell == nil) {
                    
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLSendAddressCellInSendHanDanView" owner:nil options:nil]lastObject];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                
                cell.personalHanDanDataManage = self.personalHanDanDataManage;
                cell.delegage = self;
                
                return cell;
            }
                break;
            case 3:
            {
                NSString *reuseIdentifier = @"reuseIdentifierOfPushBusinessScope";
                MQLPushBusinessScopeCellInSendHanDanView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                if (cell == nil) {
                    
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLPushBusinessScopeCellInSendHanDanView" owner:nil options:nil]lastObject];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                }
                
                cell.personalHanDanDataManage = self.personalHanDanDataManage;
                
                return cell;
                
            }
                break;
            case 4:
            {
                NSString *reuseIdentifier = @"reuseIdentifierOfConfirmOrAgain";
                MQLConfirmOrAgainCellInSendHanDanView *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                if (cell == nil) {
                    
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"MQLConfirmOrAgainCellInSendHanDanView" owner:nil options:nil]lastObject];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                }
                
                cell.personalHanDanDataManage = self.personalHanDanDataManage;
                cell.delegate = self;
                
                return cell;
            }
                break;
                
        }

    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    switch (indexPath.row) {
        case 0:
        {
            if (self.personalHanDanDataManage.charaters.length == 0) {
                
                height = 152;
            }else{
                
                height = 152;
            }
        }
            break;
        case 1:
        {
            height = 44;
        }
            break;
        case 2:
        {
            CGSize constraint = CGSizeMake(180, CGFLOAT_MAX);
            CGSize size = [self boundingRectWithSize:constraint withFont:[UIFont systemFontOfSize:18.0] withText:self.personalHanDanDataManage.sendAddress];
            height = size.height > 21.473999 ? size.height + (40 - 21.473999) : 40;
            
        }
            break;
        case 3:
        {
            height = 61;
        }
            break;
        case 4:
        {
            height = 204;
        }
            break;
            
        default:
            break;
    }
    return height;
}

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(UIFont*)font withText:(NSString*)text
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

#pragma mark -- MQLPushBusinessScopeCellInSendHanDanViewDelegate

-(void)setBusinessLocationBtnClicked
{
    MQLRequiredBusinessLocationViewController *vc = [[MQLRequiredBusinessLocationViewController alloc]initWithNibName:@"MQLRequiredBusinessLocationViewController" bundle:nil];
    
    vc.personalHanDanDataManage = self.personalHanDanDataManage;
    [self.ownerViewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- MQLConfirmOrAgainCellInSendHanDanViewDelegate

-(void)confirmSendBtnClicked
{
    if ([HSPAccountTool account].userTokenid.length == 0) {
        
        [ZYPNotificationLoginManger getNotificationFromController:self.ownerViewController];
        return;
    }
    
    
    if (self.personalHanDanDataManage.sendAddress.length) {
        
        MQLHttpRequestManage *httpRequestManage = [MQLHttpRequestManage instance];
        [httpRequestManage sendPersonalHanDanRequestWithPersonalHanDanDataManage:self.personalHanDanDataManage selectedHanDankind:self.selectedHanDankind inWhichView:ViewKind_SendHanDan];
        
        [MBProgressHUD showHUDAddedTo:self.contentTableView animated:YES];
        
    }else{
        
        [self showAlertViewWithTitle:@"提示" msg:@"请输入配送地址" tag:-1];
    }
}

-(void)hanDanAgainBtnClicked
{
    [self.ownerViewController.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -- MQLSendAddressCellInSendHanDanViewDelegate

-(void)sendAddressEditBtnClicked
{
    //注册键盘通知事件
    [self registerForKeyboardNotifications];
    
    //创建派送地址输入视图容器
    self.sendAddressInputViewContainer = [[UIView alloc]initWithFrame:self.bounds];
    self.sendAddressInputViewContainer.backgroundColor = [UIColor clearColor];
    [self addSubview:self.sendAddressInputViewContainer];
    
    //创建派送地址输入视图半透明底图
    self.sendAddressInputViewhalfTransparenceDiTu = [[UIView alloc]initWithFrame:self.sendAddressInputViewContainer.bounds];
    self.sendAddressInputViewhalfTransparenceDiTu.backgroundColor = [UIColor blackColor];
    self.sendAddressInputViewhalfTransparenceDiTu.alpha = 0.3;
    [self.sendAddressInputViewContainer addSubview:self.sendAddressInputViewhalfTransparenceDiTu];
    
    //为"派送地址输入视图半透明底图"添加单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self.sendAddressInputViewhalfTransparenceDiTu addGestureRecognizer:tap];
    
    //创建派送地址输入视图
    self.sendAddressInputView = [[[NSBundle mainBundle]loadNibNamed:@"MQLSendAddressInputView" owner:nil options:nil]lastObject];
    self.sendAddressInputView.frame = CGRectMake(self.sendAddressInputViewContainer.bounds.origin.x,
                                               self.sendAddressInputViewContainer.bounds.size.height - self.sendAddressInputView.bounds.size.height,
                                               self.sendAddressInputView.bounds.size.width,
                                               self.sendAddressInputView.bounds.size.height);
    [self.sendAddressInputViewContainer addSubview:self.sendAddressInputView];
    self.sendAddressInputView.delegate = self;
    self.sendAddressInputView.personalHanDanDataManage = self.personalHanDanDataManage;
    
}

-(void)onTap:(UITapGestureRecognizer*)tap
{
    [self clearSomethingAboutSendAddressInputView];
}

#pragma mark -- MQLSendAddressInputViewDelegate
-(void)sendAddressInputFinish
{
    [self clearSomethingAboutSendAddressInputView];
    [self refreshContentTableView];
    
}























@end
