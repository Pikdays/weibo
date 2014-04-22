//
//  WeiboAnnotation.m
//  weibo
//
//  Created by laijiawei on 14-4-22.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation

-(id)initWithModel:(WeiboModel *)weibo
{

    self=[super init];
    if (self) {
        self.model=weibo;
        
    }
    return self;

}

-(void)setModel:(WeiboModel *)model
{

    _model=model;
    
    NSDictionary *geo=model.geo;
    
    if ([geo isKindOfClass:[NSDictionary class]]) {
        NSArray *coord=[geo objectForKey:@"coordinates"];
        if (coord.count==2) {
            float lat=[[coord objectAtIndex:0]floatValue];
            float lon=[[coord objectAtIndex:1]floatValue];
            
            _coordinate=CLLocationCoordinate2DMake(lat, lon);

        }
    }

}
@end
