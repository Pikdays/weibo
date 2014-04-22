//
//  NearbyWeiboViewController.m
//  weibo
//
//  Created by laijiawei on 14-4-22.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "NearbyWeiboViewController.h"
#import "NetRequest.h"
#import "WeiboModel.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
@interface NearbyWeiboViewController ()

@end

@implementation NearbyWeiboViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"附近的微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化并开始更新 程序每次重装的时候要调试模拟器的位置，默认是没有定位的
    _locManager = [[CLLocationManager alloc] init];
    _locManager.delegate = self;
    [_locManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locManager startUpdatingLocation];
    
}


#pragma mark location delegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
        [manager stopUpdatingLocation];
    
    
    MKCoordinateRegion region={newLocation.coordinate,{0.1,0.1}};
    
    [self.mapView setRegion:region animated:YES];
    
    
        float lat=newLocation.coordinate.latitude;
        float longitude=newLocation.coordinate.longitude;
        
        //测试
//    lat=39.54;
//    longitude=116.23;

    
        NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",lat],@"lat", [NSString stringWithFormat:@"%f",longitude],@"long",nil];
        
        [NetRequest requestWithBlock:@"place/nearby_timeline.json" httpMethod:@"GET" params:params completeBlock:^(id result) {
            
            
            NSArray *statues = [result objectForKey:@"statuses"];

            
            NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];

            for (int i=0;i<statues.count;i++) {
                
                NSDictionary *statuesDic=statues[i];
                
                WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
                
                
                [weibos addObject:weibo];
                
                
                if (weibo!=nil) {
                    
                    WeiboAnnotation * weiboAnnotation=[[WeiboAnnotation alloc]initWithModel:weibo];
                    //一个个弹出来
                    [self.mapView performSelector:@selector(addAnnotation:) withObject:weiboAnnotation afterDelay:i*0.05];
                    
//                    [self.mapView addAnnotation:weiboAnnotation];
                }
  
            }

        }];

    
}




#pragma mark MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return  nil;
    }
    
    static NSString * cellid=@"WeiboAnnotationView";
    
    WeiboAnnotationView * view=(WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:cellid];
    
    
    
    if (view==nil) {
    
        view=[[WeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:cellid];
        
        
    }
    

    return view;

}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (UIView * view in views) {
        
        CGAffineTransform transform = view.transform;
        view.transform=CGAffineTransformScale(transform, 0.7, 0.7);
        view.alpha=0;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            view.transform=CGAffineTransformScale(transform, 1.2, 1.2);

            view.alpha=1;

        } completion:^(BOOL finish){
        
            [UIView animateWithDuration:0.3 animations:^{
            
                view.transform=CGAffineTransformIdentity;
            
            }];

        
        }];
    }

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
