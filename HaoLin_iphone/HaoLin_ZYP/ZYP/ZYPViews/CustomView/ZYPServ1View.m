//
//  ZYPServ1View.m
//  HaoLin
//
//  Created by mac on 14-9-18.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "ZYPServ1View.h"
@interface ZYPServ1View ()
{
//    NSBlockOperation *operation1;
    NSString *wavpath;
    AVAudioPlayer *audioPlay;
}
@property (nonatomic, assign)BOOL makeSureOneLoadIdentifier;
@end
@implementation ZYPServ1View

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
    self.userInteractionEnabled = YES;
    self.soundBtn.userInteractionEnabled = YES;
    self.stateBtn.userInteractionEnabled = YES;
    self.makeSureOneLoadIdentifier = YES;
}
- (IBAction)playSound:(id)sender
{
    
    Reachability * rp = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if (rp.currentReachabilityStatus == NotReachable)
    {
        [self alertWithMessage:@"无网络"];
    }else{
        
        if ([self.urlString hasSuffix:@".amr"])
        {
            if (self.makeSureOneLoadIdentifier == YES) {
         NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
                    self.makeSureOneLoadIdentifier = NO ;
                    [self load:[NSURL URLWithString:self.urlString]];
                }];
                [operation2 start];
            }
        }else
        {
            [self alertWithMessage:@"没有声音"];
        }
    }
}

/**
 *  下载音频文件
 *
 *  @param url 下载url
 */

- (void)load:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    /**
     *  下载音频临时文件
     */
    NSURLSessionDownloadTask *downSession = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {
        if (error == nil) {
            /**
             *  将临时文件存储到本地
             */
            NSString *path = NSTemporaryDirectory();
            NSString *pathString = [path stringByAppendingString:response.suggestedFilename];
            NSURL *newFileLocation =[NSURL fileURLWithPath:pathString];
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFileLocation error:nil];
            [self getChangeFormat:pathString];
        }else
        {
            self.makeSureOneLoadIdentifier = YES;
        }
       
    }];
    [downSession resume];
}
/**
 *  转换格式后播放本地文件
 */
- (void)getChangeFormat:(NSString *)path
{
    /**
     *  本地文件存在，就从本地读取
     */
    if ([path hasSuffix:@".amr"])
    {
        /**
         *  将amr文件转化成wav格式
         */
        wavpath = [path stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
        [MQLAudioManage encodeToWav:wavpath fromAmr:path];
        NSLog(@"%@",[NSData dataWithContentsOfFile:wavpath]);
        /**
         *  播放本地音频
         */
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        NSURL*url = [NSURL fileURLWithPath:wavpath];
        audioPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:url  error:nil];
        NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
            self.makeSureOneLoadIdentifier = YES;
            [audioPlay play];
        }];
        [operation1 start];
    }
}




//  确认服务
- (IBAction)go:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.orderView1 animated:YES];
    ZYPNetWorkGetSourceManger *manger = [[ZYPNetWorkGetSourceManger alloc] init];
    HSPAccount *account = [HSPAccountTool account];
    NSString *urlString = [NSString stringWithFormat:@"%@user_id=%@&tokenid=%@&order_id=%@&status=4",changeDingDanState,account.user_id,account.userTokenid,self.orderID];
    __weak ZYPServ1View *detailVc = self;
    [manger connectWithUrlStr:urlString completion:^(id respondObject)
     {
         [MBProgressHUD hideAllHUDsForView:detailVc.orderView1 animated:YES];
         if ([respondObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dic = respondObject;
             if ([[dic objectForKey:@"code"] intValue] == 0) {
                 [detailVc alertWithMessage:[dic objectForKey:@"message"]];
                 
                 
                 
                 /**
                  *  状态更新成功，改变btn的状态
                  */
                 [detailVc.stateBtn setTitle:@"服务中" forState:UIControlStateNormal];
                 detailVc.stateBtn.backgroundColor = [UIColor grayColor];
                 detailVc.stateBtn.enabled = NO;
             }else
             {
                 [detailVc alertWithMessage:[dic objectForKey:@"message"]];
             }
         }else
         {
             [detailVc alertWithMessage:@"发货失败,请重试"];
         }
     }];

}
//  自定义alert
- (void)alertWithMessage:(NSString *)mesage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:mesage message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
