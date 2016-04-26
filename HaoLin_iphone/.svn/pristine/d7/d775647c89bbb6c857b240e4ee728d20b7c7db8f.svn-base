//
//  MQLRecordingStatusView.m
//  Record&Play
//
//  Created by maqianli on 14-8-20.
//  Copyright (c) 2014年 maqianli. All rights reserved.
//

#import "MQLRecordingStatusView.h"

@interface MQLRecordingStatusView ()

@property (nonatomic, strong) SCGIFImageView *imageView;

/**
 *  自定义初始化
 */
-(void)customInitialization;



@end

@implementation MQLRecordingStatusView

-(void)dealloc
{
    [self.imageView resetTimer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //自定义初始化
        [self customInitialization];
        
    }
    return self;
}

#pragma mark -- MQLRecordingStatusView函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.backgroundColor = [UIColor clearColor];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"MQLMicRecord" ofType:@"gif"];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    self.imageView = [[SCGIFImageView alloc]initWithFrame:CGRectMake
                                            ((self.bounds.size.width - 200) / 2.0,
                                            (self.bounds.size.height - 200) / 2.0,
                                            200,
                                             200)];
    
    [self.imageView setData:imageData];
    [self addSubview:self.imageView];
    
}

@end
