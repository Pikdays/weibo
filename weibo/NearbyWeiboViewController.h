//
//  NearbyWeiboViewController.h
//  weibo
//
//  Created by laijiawei on 14-4-22.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "BaseViewController.h"
@interface NearbyWeiboViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@property(nonatomic,retain) CLLocationManager *locManager ;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
