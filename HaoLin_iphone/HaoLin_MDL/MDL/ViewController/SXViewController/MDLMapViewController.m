//
//  MDLMapViewController.m
//  HaoLin
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MDLMapViewController.h"

@interface MDLMapViewController ()<BMKGeoCodeSearchDelegate,BMKMapViewDelegate>
{
    BMKMapView* mapView;
    BMKPointAnnotation* annotation;
}
@property (nonatomic , strong)BMKGeoCodeSearch * searcher;

@end


@implementation MDLMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        precisionString1=nil;
//        dimensionString1=nil;
        address=nil;
        [[NSNotificationCenter defaultCenter]  addObserver:self
                                                  selector:@selector(NOTUserAxis:)
                                                      name:@"UserAxis"
                                                    object:nil];
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self buzhi];
//    [super viewWillAppear:animated];
//    [self.requiredBusinessLocationView viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
//    [super viewWillDisappear:animated];
//    [self.requiredBusinessLocationView viewWillDisappear];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //返回抢单界面
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (listitmAction) name:@"popQDjiemian" object:nil];
    
//    [self customInitialization];
//    [self addRequiredBusinessLocationView];
}
-(void)NOTUserAxis:(NSNotification *)not
{
    NSDictionary *Axdic =[not object];
    address =[Axdic objectForKey:@"address"];
//    NSString *axisstr=[Axdic objectForKey:@"axis"];
//    NSArray *axdic =[axisstr componentsSeparatedByString:@","];
//    precisionString1=[axdic objectAtIndex:0];
//    dimensionString1=[axdic objectAtIndex:1];
}

-(void)customInitialization
{
    self.view.backgroundColor = BGColor;
}

-(void)buzhi
{
//    MDLQDMapView *mapview=[[[NSBundle mainBundle]loadNibNamed:@"MDLQDMapView" owner:self options:nil]lastObject];
//    mapview.backgroundColor=BGColor;
//    [self.view addSubview:mapview];
    
    [self initmanview];
    UIView *nvview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 65)];
    [self.view addSubview:nvview];
    nvview.backgroundColor=[UIColor clearColor];
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(8, 28, 30, 30);
    [nvview addSubview:backbtn];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"MDLfanhui@2x"] forState:(UIControlStateNormal)];
    [backbtn addTarget:self action:@selector(listitmAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initmanview
{
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth,KDeviceHeight)];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    annotation = [[BMKPointAnnotation alloc]init];

    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    //    geoCodeSearchOption.city= @"北京市";
    geoCodeSearchOption.address = address;
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation1
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.image = [UIImage imageNamed:@"MDLplace@2x"];
        return newAnnotationView;
    }
    return nil;
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"定位获取到的经纬度:%f",result.location.latitude);
        
        CLLocationCoordinate2D coor;
        
        coor.latitude  = result.location.latitude;
        coor.longitude = result.location.longitude;
        annotation.title = result.address;
        
        annotation.coordinate = coor;
        
        float zoomLevel = 0.01;
        BMKCoordinateRegion region = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(zoomLevel, zoomLevel));
        [mapView setRegion:[mapView regionThatFits:region] animated:YES];
        [mapView addAnnotation:annotation];
        [mapView selectAnnotation:annotation animated:YES];    //常态显示气泡
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

-(void)listitmAction
{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
