//
//  HSPFeedbackViewController.m
//  HaoLin
//
//  Created by PING on 14-8-28.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "HSPFeedbackViewController.h"

@interface HSPFeedbackViewController () <UITextViewDelegate>

@property (nonatomic, assign) int feedbackType;
@property (weak, nonatomic) HSPTextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *ideaBtn;
@property (weak, nonatomic) IBOutlet UIButton *wrongBtn;
- (IBAction)submit:(id)sender;

- (IBAction)checkBtnClick:(UIButton *)sender;

@property (nonatomic, strong) HSPHttpRequest *request;



@end

@implementation HSPFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = HSPBgColor;
    }
    return self;
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.alwaysBounceHorizontal = YES;
    
    self.title = @"意见反馈";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HSPFontColor,NSForegroundColorAttributeName, nil]];
    
    HSPTextView *textView = [[HSPTextView alloc] init];
    textView.placeholder = @"请发表您的评论...";
    textView.font = [UIFont systemFontOfSize:16];
    textView.frame = CGRectMake(10, 85, self.view.width - 20, 140);
    [self.view addSubview:textView];
    textView.layer.borderWidth = 1;
    CGColorRef cgColor = HSPColor(218, 218, 218).CGColor;
    textView.layer.borderColor = cgColor;
    textView.placeholderColor = [UIColor lightGrayColor];
    self.textView = textView;
    // 设置输入框无论什么时候都可以滚动
    _textView.alwaysBounceVertical = YES;
    _textView.delegate = self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[UITextField class]] || [obj isKindOfClass:[UITextView class]]) {
            [obj resignFirstResponder];
        }
    }
}


- (IBAction)submit:(id)sender {
    
    if (!self.textView.text.length ) {
        [self.textView becomeFirstResponder];
        return;
    }
    
    HSPAccount *account = [HSPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = account.user_id;
    params[@"tokenid"] = account.userTokenid;
    params[@"opinion_type"] = [NSString stringWithFormat:@"%d",self.feedbackType + 1];
    params[@"opinion_desc"] = self.textView.text;
    params[@"opinion_mobile"] = self.phoneNumber.text;
    __weak JZDCustomAlertView *alert = [JZDCustomAlertView sharedInstace];
    [self.request connectionREquesturl:feedbackUrl withPostDatas:params withDelegate:nil withBackBlock:^(id backDictionary) {
        
        if ([[backDictionary objectForKey:@"code"] isEqualToString:@"0"]) {
            [alert popAlert:[backDictionary objectForKey:@"message"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [alert popAlert:[backDictionary objectForKey:@"message"]];
            return;
        }
        
    }];
}

- (IBAction)checkBtnClick:(UIButton *)sender {
//    YYLog(@"==%d",sender.tag);
    self.feedbackType = sender.tag + 1;
    sender.selected = !sender.isSelected;
    if (sender == self.ideaBtn ) {
        self.wrongBtn.selected = NO;
    }else if(sender == self.wrongBtn){
        self.ideaBtn.selected = NO;
    }else{
        self.ideaBtn.selected = YES;
    }
}

#pragma mark - 懒加载
- (HSPHttpRequest *)request
{
    if (!_request) {
        _request = [HSPHttpRequest Instace];
    }
    return _request;
}

@end
