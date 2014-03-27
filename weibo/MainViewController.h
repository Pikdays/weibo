//
//  MainViewController.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "ThemeImageView.h"
#import "HomeViewController.h"
@interface MainViewController : UITabBarController<SinaWeiboDelegate,SinaWeiboRequestDelegate>
{

    UIView * _tabbarView;
    UIImageView * _sliderView;
    ThemeImageView * _noreadView;
   
    
}

-(void)shownoread:(BOOL)show;

@property(nonatomic,retain) NSArray * views;

@property(nonatomic,assign)NSNumber * noread_count;    //未读微博数目



@end
