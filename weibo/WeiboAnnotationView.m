//
//  WeiboAnnotationView.m
//  weibo
//
//  Created by laijiawei on 14-4-22.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
@implementation WeiboAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView
{

    userImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    userImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    userImageView.layer.borderWidth=1;
    weiboImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    
    //内容不拉伸
//    weiboImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    weiboImageView.backgroundColor=[UIColor blackColor];
    label=[[UILabel alloc]initWithFrame:CGRectZero];

    label.textColor=[UIColor whiteColor];
    
    label.font=[UIFont systemFontOfSize:12.0];
    
    label.backgroundColor=[UIColor clearColor];
    
    label.numberOfLines=3;
    
    
    [self addSubview:weiboImageView];

    [self addSubview:label];
    
    [self addSubview:userImageView];


}

-(void)layoutSubviews
{

    
    [super layoutSubviews];
    
    WeiboAnnotation * an=self.annotation;
    if ([an isKindOfClass:[WeiboAnnotation class]]) {
        
        WeiboModel * model=an.model;
        
        
        
        NSString * timg=model.thumbnailImage;
        if (timg.length>0) {
            self.image=[UIImage imageNamed:@"nearby_map_photo_bg.png"];
            weiboImageView.frame=CGRectMake(15, 15, 90, 85);
            
            [weiboImageView setImageWithURL:[NSURL URLWithString:timg]];
            
            userImageView.frame=CGRectMake(70, 70, 30, 30);
            NSString *userurl=model.user.profile_image_url;
            [userImageView setImageWithURL:[NSURL URLWithString:userurl]];
            
            label.hidden=YES;

        }else{
            
            userImageView.frame=CGRectMake(20, 20, 45, 45);
            NSString *userurl=model.user.profile_image_url;
            [userImageView setImageWithURL:[NSURL URLWithString:userurl]];
        
            self.image=[UIImage imageNamed:@"nearby_map_content.png"];
            
            label.frame=CGRectMake(userImageView.right+5, userImageView.top, 110, 45);
            label.text=model.text;
            
            //考虑复用
            weiboImageView.hidden=YES;
            label.hidden=NO;
            NSLog(@"ok");


        }
        
    }
    
    
    
    


}
@end
