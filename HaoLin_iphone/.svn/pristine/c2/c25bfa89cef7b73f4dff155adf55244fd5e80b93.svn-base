//
//  MDLFenleiview.m
//  HaoLin
//
//  Created by apple on 14-9-3.
//  Copyright (c) 2014年 hlsd. All rights reserved.
//

#import "MDLFenleiview.h"

@interface MDLFenleiview()
{
    MDLbasicdataobj   *basicdataobj;
    MDLNetworkservice *Networkservice;
    ZYPObjectManger   *zypobjectmanger;
    MDLgoodsdata      *goosdata;
}

@end

@implementation MDLFenleiview

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
    _Fenleitableview.delegate = self;
    _Fenleitableview.dataSource =self;
    
    basicdataobj   =[MDLbasicdataobj sharebasicdataobj];
    Networkservice =[MDLNetworkservice shareservice];
    zypobjectmanger=[ZYPObjectManger shareInstance];
    goosdata       =[[MDLgoodsdata alloc]init];

    [self.Fenleitableview reloadData];
    
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [basicdataobj.xzdata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_Fenleitableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text=[[basicdataobj.xzdata objectAtIndex:indexPath.row]objectForKey:@"cat_name"];
    }
    return cell;
    
}
#pragma mark UITableViewDelegate End -

#pragma mark  点击事件

- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)path
{
    
        [Networkservice ConnectToobtaindic:zypobjectmanger.loginInObject.user_id tokenid:zypobjectmanger.loginInObject.tokenid catid:[[basicdataobj.xzdata objectAtIndex:path.row] objectForKey:@"cat_id"] page:nil withJSON:^(id responseObject) {
        
        NSMutableDictionary *dic =responseObject;
        NSLog(@"%@",[dic objectForKey:@"message"]);
            
            for (id data in [dic objectForKey:@"data"]) {
                
                goosdata.goodsid=[data objectForKey:@"goods_id"];
                goosdata.goodsname=[data objectForKey:@"goods_name"];
                goosdata.goodsprice=[data objectForKey:@"goods_price"];
            }
        
    }];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"tableviewreloadData" object:nil];
}

@end
