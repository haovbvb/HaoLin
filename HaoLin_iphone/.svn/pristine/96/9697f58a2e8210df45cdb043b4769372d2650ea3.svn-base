//
//  MDLInformationView.m
//  HAOLINAPP
//
//  Created by apple on 14-8-11.
//  Copyright (c) 2014年 com.haolinshidai. All rights reserved.
//

#import "MDLInformationView.h"
#import "MDLinformationTableViewCell.h"

@implementation MDLInformationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initview];
        
    }
    return self;
}

-(void)initview
{
    _QDarry =[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    self.informationtableView=[[UITableView alloc]init];
    _informationtableView.BackgroundColor=BGColor;
    if (DEVICE_IS_IPHONE5) {
        self.informationtableView.frame=CGRectMake(0, 0, KDeviceWidth,KDeviceHeight);
    }else{
        self.informationtableView.frame=CGRectMake(0, 0, KDeviceWidth,KDeviceHeight-60);
    }
        _informationtableView.delegate = self;
        _informationtableView.dataSource =self;
        [self addSubview:_informationtableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.QDarry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//     MDLinformationTableViewCell *cell = [self tableView:_informationtableView cellForRowAtIndexPath:indexPath] ;
//    MDLinformationTableViewCell *cell;
//    return cell.frame.size.height;
    return 120;
}
//绘制单元格
-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    static NSString *simpleTableIdentifier = @"MDLinformationTableViewCell";
    
    MDLinformationTableViewCell *cell = (MDLinformationTableViewCell *)[_informationtableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MDLinformationTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    cell.timelable.text=[_QDarry objectAtIndex:indexPath.row];
    [cell.stopbutton addTarget:self action:@selector(deletecell:) forControlEvents:UIControlEventTouchUpInside];
    cell.stopbutton.tag=indexPath.row;

       return cell;
}
-(void)deletecell:(UIButton *)sender
{
    NSUInteger tag=sender.tag;
    [_QDarry removeObjectAtIndex:tag];
    [self.informationtableView reloadData];
    
}
- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)path {
    
    //点击cell的时候 界面回立即抢单界面回原位
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yuanweiNotificationCenter" object:nil];

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
