//
//  HSPRatingViewController.m
//  HaoLin
//
//  Created by PING on 14-9-15.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPRatingViewController.h"

@interface HSPRatingViewController ()<UITextViewDelegate,HSPRatingViewDelegate>
@property (weak, nonatomic) HSPTextView *textView;
@property (nonatomic, assign) int newRating;
@property (nonatomic, strong) HSPHttpRequest *request;



@end

@implementation HSPRatingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = HSPBgColor;
        self.starBgView.backgroundColor = HSPSubBgColor;
        self.ratingBgView.backgroundColor = HSPSubBgColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self UIConfig];
}


- (void)backRootController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)UIConfig
{
    _navBgView.backgroundColor = HSPBarBgColor;
    self.title = @"评价";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor, NSForegroundColorAttributeName, nil]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    [rightItem setTintColor:HSPFontColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 星星
    [_ratingView setImagesDeselected:@"HSP_star2" partlySelected:@"HSP_star1" fullSelected:@"HSP_star1" andDelegate:self];
	[_ratingView displayRating:4];
    
    HSPTextView *textView = [[HSPTextView alloc] init];
    textView.placeholder = @"请发表您的评论...";
    textView.frame = CGRectMake(10, 10, self.view.width - 20, 120);
    [_ratingBgView addSubview:textView];
    textView.layer.borderWidth = 1;
    CGColorRef cgColor = HSPBgColor.CGColor;
    textView.layer.borderColor = cgColor;
    textView.placeholderColor = [UIColor lightGrayColor];
    self.textView = textView;
    // 设置输入框无论什么时候都可以滚动
    _textView.alwaysBounceVertical = YES;
    _textView.delegate = self;
}

- (void)submit
{
    [self submitRequest];
}

- (void)submitRequest
{
    HSPAccount *account = [HSPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = account.user_id;
    params[@"tokenid"] = account.userTokenid;
    params[@"order_id"] = [NSString stringWithFormat:@"%d",_orderId];
    params[@"score"] = [NSString stringWithFormat:@"%d",self.newRating];
    params[@"comment_info"] = self.textView.text;
    [self.request connectionREquesturl:orderCommentUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        
        JZDCustomAlertView *alertView = [[JZDCustomAlertView alloc] init];
        [alertView popAlert:[backDictionary objectForKey:@"message"]];
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
}


#pragma mark - HSPRatingViewDelegate
- (void)ratingChanged:(float)newRating
{
    self.newRating = (int)newRating;
}

#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [HSPHttpRequest Instace];
    }
    return _request;
}

- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitBtnClick:(UIButton *)sender {
    [self submitRequest];
}
@end
