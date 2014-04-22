//
//  WeiboAnnotationView.h
//  weibo
//
//  Created by laijiawei on 14-4-22.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeiboAnnotationView : MKAnnotationView
{

    UIImageView * userImageView;//用户头像
    UIImageView * weiboImageView;//微博

    UILabel * label;//微博内容
}
@end
