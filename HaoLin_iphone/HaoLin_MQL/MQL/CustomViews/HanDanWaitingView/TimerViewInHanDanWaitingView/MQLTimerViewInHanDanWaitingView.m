//
//  MQLTimerViewInHanDanWaitingView.m
//  HaoLin
//
//  Created by MQL on 14-9-4.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLTimerViewInHanDanWaitingView.h"

@interface MQLTimerViewInHanDanWaitingView ()

@property (nonatomic, weak) IBOutlet UIImageView *circularityImageView;
@property (nonatomic, weak) IBOutlet UILabel *timerLab;
@property (nonatomic, weak) IBOutlet UILabel *merchant_numLab;
@property (nonatomic, strong) NSTimer *waitingTimer;
@property (nonatomic) int counter;

/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  注册通知
 */
-(void)registerNotifications;

/**
 *  让圆转起来
 */
-(void)letCircularityRotating;

/**
 *  启动等待定时器
 */
-(void)startWaitingTimer;


@end

@implementation MQLTimerViewInHanDanWaitingView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    
    //注册通知
    [self registerNotifications];
    
    //让圆转起来
    [self letCircularityRotating];
    
    
}

-(void)setDataOfHanDanOver:(NSDictionary *)dataOfHanDanOver
{
    _dataOfHanDanOver = dataOfHanDanOver;
    
    int merchant_num = [[dataOfHanDanOver objectForKey:@"merchant_num"]intValue];
    self.merchant_numLab.text= [NSString stringWithFormat:@"已推送%d个商家", merchant_num];
    
    int user_waittime = [[dataOfHanDanOver objectForKey:@"user_waittime"]intValue];
    self.counter = user_waittime;
    [self startWaitingTimer];    //启动等待定时器
    
}

#pragma mark --MQLTimerViewInHanDanWaitingView函数扩展
/**
 *  自定义初始化
 */
-(void)customInitialization
{

}

/**
 *  注册通知
 */
-(void)registerNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onReceiveNotificationOfSendToPersonal:) name:NotificationOfSendToPersonal object:nil];
}

-(void)onReceiveNotificationOfSendToPersonal:(NSNotification*)notification
{
    NSLog(@"userInfo = %@", notification.userInfo);
    
    NSString *talk_idOfWaiting = [self.dataOfHanDanOver objectForKey:@"talk_id"];
    NSString *talk_idOfReceive = [notification.userInfo objectForKey:@"talk_id"];
    
    if ([talk_idOfWaiting compare:talk_idOfReceive] == 0) {
        
        if ([self.delegate respondsToSelector:@selector(stopWaitingWithReceiveTalk_id:)]) {
            
            [self.waitingTimer invalidate];
            self.waitingTimer = nil;
            
            [self.delegate stopWaitingWithReceiveTalk_id:talk_idOfReceive];
        }
        
    }
}

/**
 *  让圆转起来
 */
-(void)letCircularityRotating
{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.removedOnCompletion = NO;
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 0.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = FLT_MAX;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,self.circularityImageView.frame.size.width, self.circularityImageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [self.circularityImageView.image drawInRect:CGRectMake(1,1,self.circularityImageView.frame.size.width-2,self.circularityImageView.frame.size.height-2)];
    self.circularityImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.circularityImageView.layer addAnimation:animation forKey:nil];

}

/**
 *  启动等待定时器
 */
-(void)startWaitingTimer
{
    self.waitingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [self.waitingTimer fire];
}

-(void)onTimer:(NSTimer*)sender
{
    if (self.counter == 0) {
        
        //等待结束
        [self.waitingTimer invalidate];
        self.waitingTimer = nil;
        
        if ([self.delegate respondsToSelector:@selector(waitingOver)]) {
            
            [self.delegate waitingOver];
        }

        
    }else{
        self.timerLab.text = [NSString stringWithFormat:@"%d秒", self.counter];
        self.counter--;
        
    }
    
}

@end
