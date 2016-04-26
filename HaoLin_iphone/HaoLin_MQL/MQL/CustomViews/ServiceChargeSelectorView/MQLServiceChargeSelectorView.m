//
//  MQLServiceChargeSelectorView.m
//  HaoLin
//
//  Created by MQL on 14-8-23.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MQLServiceChargeSelectorView.h"

@interface MQLServiceChargeSelectorView ()

@property CGPoint point0;
@property CGPoint point1;
@property CGPoint point2;
@property CGPoint point3;
@property CGPoint point4;
@property CGPoint point5;

@property (nonatomic) CGPoint startPoint;
@property (nonatomic, strong) UIImageView *serviceChargeResult;


/**
 *  自定义初始化
 */
-(void)customInitialization;

/**
 *  添加滑动手势
 */
-(void)addPanGesture;

/**
 *  添加点击手势
 */
-(void)addTapGesture;


@end

@implementation MQLServiceChargeSelectorView

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

-(void)setServiceCharge:(int)serviceCharge
{
    _serviceCharge = serviceCharge;
    
    switch (serviceCharge) {
        case 0:
            self.serviceChargeResult.center = self.point0;
            break;
        case 1:
            self.serviceChargeResult.center = self.point1;
            break;
        case 2:
            self.serviceChargeResult.center = self.point2;
            break;
        case 3:
            self.serviceChargeResult.center = self.point3;
            break;
        case 4:
            self.serviceChargeResult.center = self.point4;
            break;
        case 5:
            self.serviceChargeResult.center = self.point5;
            break;
            
        default:
            break;
    }
    

}

#pragma mark --MQLServiceChargeSelectorView函数扩展

/**
 *  自定义初始化
 */
-(void)customInitialization
{
    self.point0 = CGPointMake(0 + 40 * 0 + 16 / 2, 24);
    self.point1 = CGPointMake(0 + 40 * 1 + 16 / 2, 24);
    self.point2 = CGPointMake(0 + 40 * 2 + 16 / 2, 24);
    self.point3 = CGPointMake(0 + 40 * 3 + 16 / 2, 24);
    self.point4 = CGPointMake(0 + 40 * 4 + 16 / 2, 24);
    self.point5 = CGPointMake(0 + 40 * 5 + 16 / 2, 24);
    
    self.serviceChargeResult = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MQLServiceChargeResult"]];
    self.serviceChargeResult.userInteractionEnabled = YES;
    self.serviceChargeResult.bounds = CGRectMake(0, 0, 32, 32);
    
    [self addSubview:self.serviceChargeResult];
    
    //添加滑动手势
    [self addPanGesture];
    
    //添加点击手势
    [self addTapGesture];
    
}

/**
 *  添加滑动手势
 */
-(void)addPanGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onPan:)];
    
    [self.serviceChargeResult addGestureRecognizer:pan];
}

-(void)onPan:(UIPanGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.startPoint = [recognizer locationInView:recognizer.view];
        
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        
        CGPoint newPoint = [recognizer locationInView:recognizer.view];
        CGFloat deltaX = newPoint.x - self.startPoint.x;
        
        CGFloat X = self.serviceChargeResult.center.x + deltaX;
        if (X <= self.point5.x && X >=self.point0.x) {
            
             self.serviceChargeResult.center = CGPointMake(X, self.serviceChargeResult.center.y);
        }

        
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        
        //先确定范围
        CGPoint pointMin = CGPointZero;
        CGPoint pointMax = CGPointZero;
        if (self.serviceChargeResult.center.x < self.point0.x) {
            
            pointMin = self.point0;
            pointMax = self.point1;
            
        }else if (self.serviceChargeResult.center.x >= self.point0.x && self.serviceChargeResult.center.x <= self.point1.x) {
            
            pointMin = self.point0;
            pointMax = self.point1;
            
        }else if (self.serviceChargeResult.center.x >= self.point1.x && self.serviceChargeResult.center.x <= self.point2.x){
            
            pointMin = self.point1;
            pointMax = self.point2;
            
        }else if (self.serviceChargeResult.center.x >= self.point2.x && self.serviceChargeResult.center.x <= self.point3.x){
            
            pointMin = self.point2;
            pointMax = self.point3;
            
        }else if (self.serviceChargeResult.center.x >= self.point3.x && self.serviceChargeResult.center.x <= self.point4.x){
            
            pointMin = self.point3;
            pointMax = self.point4;
            
        }else if (self.serviceChargeResult.center.x >= self.point4.x && self.serviceChargeResult.center.x <= self.point5.x){
            
            pointMin = self.point4;
            pointMax = self.point5;
            
        }else if (self.serviceChargeResult.center.x > self.point5.x){
            
            pointMin = self.point4;
            pointMax = self.point5;
        }

        if (fabs(self.serviceChargeResult.center.x - pointMin.x) > fabs(self.serviceChargeResult.center.x - pointMax.x)) {
            
            self.serviceChargeResult.center = pointMax;
        }else{
            
            self.serviceChargeResult.center = pointMin;
        }
        
        if ([self.delegate respondsToSelector:@selector(serviceChargeSelectorValueChanged:)]) {
            
            self.serviceCharge = (self.serviceChargeResult.center.x - 8) / 40;
            [self.delegate serviceChargeSelectorValueChanged:self.serviceCharge];
        }
    }
    
}

/**
 *  添加点击手势
 */
-(void)addTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tap];
}

-(void)onTap:(UITapGestureRecognizer*)recognizer
{
    CGPoint point = [recognizer locationInView:self];
    //先确定范围
    CGPoint pointMin = CGPointZero;
    CGPoint pointMax = CGPointZero;
    if (point.x < self.point0.x) {
        
        pointMin = self.point0;
        pointMax = self.point1;
        
    }else if (point.x >= self.point0.x && point.x <= self.point1.x) {
        
        pointMin = self.point0;
        pointMax = self.point1;
        
    }else if (point.x >= self.point1.x && point.x <= self.point2.x){
        
        pointMin = self.point1;
        pointMax = self.point2;
        
    }else if (point.x >= self.point2.x && point.x <= self.point3.x){
        
        pointMin = self.point2;
        pointMax = self.point3;
        
    }else if (point.x >= self.point3.x && point.x <= self.point4.x){
        
        pointMin = self.point3;
        pointMax = self.point4;
        
    }else if (point.x >= self.point4.x && point.x <= self.point5.x){
        
        pointMin = self.point4;
        pointMax = self.point5;
        
    }else if (point.x > self.point5.x){
        
        pointMin = self.point4;
        pointMax = self.point5;
    }
    
    
    if (fabs(point.x - pointMin.x) > fabs(point.x - pointMax.x)) {
        
        self.serviceChargeResult.center = pointMax;
    }else{
        
        self.serviceChargeResult.center = pointMin;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(serviceChargeSelectorValueChanged:)]) {
        
        self.serviceCharge = (self.serviceChargeResult.center.x - 8) / 40;
        [self.delegate serviceChargeSelectorValueChanged:self.serviceCharge];
    }

}


@end
