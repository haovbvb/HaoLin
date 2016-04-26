//
//  MDLQDMapView.m
//  HaoLin
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MDLQDMapView.h"



@implementation MDLQDMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
-(void)awakeFromNib
{
    axdic =[[NSMutableArray alloc]initWithCapacity:0];
    [self.mapbackbtn setBackgroundImage:[UIImage imageNamed:@"MDLfanhui@2x"] forState:UIControlStateNormal];
    
//    [[NSNotificationCenter defaultCenter]  addObserver:self
//                                              selector:@selector(NOTUserAxis:)
//                                                  name:@"UserAxis"
//                                                object:nil];

    [self initmanview];
}

- (IBAction)poprootbtn:(id)sender {
    //地图返回BACK通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"popQDjiemian" object:nil];
  }

-(void)NOTUserAxis:(NSNotification *)not
{
    NSDictionary *Axdic =[not object];
    NSString *axisstr=[Axdic objectForKey:@"useraxis"];
    [axdic addObject:[axisstr componentsSeparatedByString:@","]];
    precisionString1=[axdic objectAtIndex:0];
    dimensionString1=[axdic objectAtIndex:1];
    address =[Axdic objectForKey:@"delivery_address"];
}

-(void)initmanview
{
//    BMKMapManager*mapManager = [[BMKMapManager alloc]init];
//     BOOL ret = [mapManager start:@"2772BD5CAFF652491F65707D6D5E9ABEBF3639CC"generalDelegate:self];
//     if (!ret) {
//         NSLog(@"manager start failed!");
//    }
     //创建一张百度地图
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,self.mapnavbar.frame.size.height, KDeviceWidth,KDeviceHeight)];
//     mapView.delegate = self;
     [self addSubview:mapView];
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;

    coor.latitude = [precisionString1 floatValue];
    coor.longitude =[dimensionString1 floatValue];
    annotation.title = tietletext;

    annotation.title = address;
    
//    [self mapView:mapView viewForAnnotation:annotation];  //大头针动画
    annotation.coordinate = coor;

    float zoomLevel = 0.01;
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(zoomLevel, zoomLevel));
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];

    [mapView addAnnotation:annotation];
    [mapView selectAnnotation:annotation animated:YES];    //常态显示气泡
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.image = [UIImage imageNamed:@""];

        return newAnnotationView;
    }
    return nil;
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
