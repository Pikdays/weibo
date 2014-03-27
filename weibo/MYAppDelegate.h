//
//  MYAppDelegate.h
//  weibo
//
//  Created by laijiawei on 14-3-15.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SinaWeibo;
@class MainViewController;

@interface MYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,retain)SinaWeibo * sinaweibo;

@property(nonatomic,retain) MainViewController * main;
@end
