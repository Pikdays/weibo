//
//  WeiboAnnotation.h
//  weibo
//
//  Created by laijiawei on 14-4-22.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"
@interface WeiboAnnotation : NSObject<MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, retain) WeiboModel * model;

-(id)initWithModel:(WeiboModel *)weibo;
@end
