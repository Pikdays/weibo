//
//  NearbyViewController.m
//  weibo
//
//  Created by laijiawei on 14-4-6.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "NearbyViewController.h"
#import "UIImageView+WebCache.h"
#import "UiFactory.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton=NO;
        self.isCancelButton=YES;     }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    self.title=@"我在这里";
    
    self.tableView.hidden=YES;
    
    // 初始化并开始更新 程序每次重装的时候要调试模拟器的位置，默认是没有定位的
    _locManager = [[CLLocationManager alloc] init];
    _locManager.delegate = self;
    [_locManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locManager startUpdatingLocation];
    
    NSLog(@"end");
    
}


#pragma mark UITableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return  self.data.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid=@"celleid";
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];

    }
    
    NSDictionary * dic=[self.data objectAtIndex:indexPath.row];
    
    NSString *title=[dic objectForKey:@"title"];
    NSString *address=[dic objectForKey:@"address"];
    NSString *icon=[dic objectForKey:@"icon"];
    
    if (![title isKindOfClass:[NSNull class]]) {
        cell.textLabel.text=title;
    }
    
    if (![address isKindOfClass:[NSNull class]]) {
        cell.detailTextLabel.text=address;
    }
    
    if (![icon isKindOfClass:[NSNull class]]) {
        
        //解决图片不显示
        [cell.imageView setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"page_image_loading.png"]];
    }
    
    
    return cell;
}



#pragma mark location delegate
- (void)locationManager:(CLLocationManager *)manager
      didUpdateToLocation:(CLLocation *)newLocation
             fromLocation:(CLLocation *)oldLocation{
    
    [manager stopUpdatingLocation];
    
    if (self.data==nil) {
        
        float lat=newLocation.coordinate.latitude;
        float longitude=newLocation.coordinate.longitude;
        
        //测试
        lat=23.11705;
        longitude=113.27599;
        
        
        NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",lat],@"lat", [NSString stringWithFormat:@"%f",longitude],@"long",nil];
        
        
          [self.sinaweibo requestWithTAG:@"place/nearby/pois.json" params:params httpMethod:@"GET" tag:@"100" delegate:self];
        
        [super showhud];
    }
    NSLog(@"hello");
    
}
- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{
     [ super showhud_custom:@"加载完成"];
    
     NSLog(@"%@",result);
    
    
        self.data=[result objectForKey:@"pois"];
        
        self.tableView.hidden=NO;
        
        [self.tableView reloadData];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (_selectblock!=nil) {
        NSDictionary * dic=[self.data objectAtIndex:indexPath.row];
        
        _selectblock(dic);
        
        
    }
 
    [self disView];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
