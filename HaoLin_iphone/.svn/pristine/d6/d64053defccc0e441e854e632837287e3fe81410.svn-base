//
//  MQLHanDanAudioRecordView.m
//  HaoLin
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLHanDanAudioRecordView.h"

@interface MQLHanDanAudioRecordView ()

@property (nonatomic, copy) NSString *wavFilePath;

@property (nonatomic, weak) IBOutlet UIButton *changeToCharacterInputBtn;
@property (nonatomic, weak) IBOutlet UIButton *recordDownBtn;

-(IBAction)changeToCharacterInputBtnClicked:(id)sender;

-(IBAction)recordDownBtnTouchDown:(id)sender;
-(IBAction)recordDownBtnTouchUpInside:(id)sender;
-(IBAction)recordDownBtnTouchUpOutside:(id)sender;

/**
 *  自定义初始化
 */
-(void)customInitialization;


@end

@implementation MQLHanDanAudioRecordView

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

#pragma mark --MQLHanDanAudioRecordView函数扩展

-(IBAction)changeToCharacterInputBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(changeToCharacterInput)]) {
        
        [self.delegate changeToCharacterInput];
        
    }
}

-(IBAction)recordDownBtnTouchDown:(id)sender
{
    NSLog(@"recordDownBtnTouchDown");
    
    //先提供wav的存放地址
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *supportDirectory = [paths objectAtIndex:0];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:supportDirectory isDirectory:&isDir] || !isDir) {
        [fileManager createDirectoryAtPath:supportDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [self addSkipBackupAttributeToFileAtPath:supportDirectory];
    
    self.wavFilePath = [supportDirectory stringByAppendingPathComponent:@"mql.wav"];
    
    MQLAudioManage *manage = [MQLAudioManage instance];
    [manage startRecordFromView:sender withWavFilePath:self.wavFilePath];
    
}

/**
 *  去掉文件备份属性
 */
- (BOOL)addSkipBackupAttributeToFileAtPath:(NSString *)aFilePath
{
    if (!([[NSFileManager defaultManager] fileExistsAtPath:aFilePath])) {
        return NO;
    }
    
    {
        NSDictionary *attribute = [[NSURL fileURLWithPath:aFilePath] resourceValuesForKeys:[NSArray arrayWithObjects:NSURLIsExcludedFromBackupKey, nil] error:nil];
        
        if ([[attribute objectForKey:NSURLIsExcludedFromBackupKey]boolValue]) {
            return YES;
        }
    }
    
    NSError *error = nil;
    BOOL success = NO;
    
    success = [[NSURL fileURLWithPath:aFilePath] setResourceValue:[NSNumber numberWithBool:YES]
                                                           forKey:NSURLIsExcludedFromBackupKey
                                                            error:&error];
    
    if(!success)
    {
        NSLog(@"Error excluding %@ from backup %@", [aFilePath lastPathComponent], error);
    }
    
    return success;
}

-(IBAction)recordDownBtnTouchUpInside:(id)sender
{
    NSLog(@"recordDownBtnTouchUpInside");

    if ([self.delegate respondsToSelector:@selector(showSendHanDanViewAfterRecordFinish:)]) {
        
        [self.delegate showSendHanDanViewAfterRecordFinish:self.wavFilePath];
    }
    
    MQLAudioManage *manage = [MQLAudioManage instance];
    [manage stopRecord];
}

-(IBAction)recordDownBtnTouchUpOutside:(id)sender
{
    NSLog(@"recordDownBtnTouchUpOutside");
    
    if ([self.delegate respondsToSelector:@selector(showSendHanDanViewAfterRecordFinish:)]) {
        
        [self.delegate showSendHanDanViewAfterRecordFinish:self.wavFilePath];
    }
    
    MQLAudioManage *manage = [MQLAudioManage instance];
    [manage stopRecord];
}

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    [MQLAudioManage instance];
    
    [self.changeToCharacterInputBtn setImage:[UIImage imageNamed:@"MQLChangeToCharacterNormalBtn"] forState:UIControlStateNormal];
    [self.changeToCharacterInputBtn setImage:[UIImage imageNamed:@"MQLChangeToCharacterSelectedBtn"] forState:UIControlStateHighlighted];
    
    [self.recordDownBtn setBackgroundImage:[UIImage imageNamed:@"MQLRecordDownNormalBtn"] forState:UIControlStateNormal];
    [self.recordDownBtn setBackgroundImage:[UIImage imageNamed:@"MQLRecordDownSelectedBtn"] forState:UIControlStateHighlighted];
    
}


@end
