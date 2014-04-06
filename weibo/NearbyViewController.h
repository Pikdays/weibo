//
//  NearbyViewController.h
//  weibo
//
//  Created by laijiawei on 14-4-6.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
typedef void (^SelectBlock) (NSDictionary *);

@interface NearbyViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,SinaWeiboRequestDelegate>
@property(nonatomic,retain)NSArray * data;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,retain)SelectBlock selectblock;

@property(nonatomic,retain) CLLocationManager *locManager ;
@end
