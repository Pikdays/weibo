//
//  BaseNavigationController.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeManager.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:KThemeDidChangeNotification object:nil];
    
    [self loadThemeImage];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadThemeImage
{

    float version=WXHLOSVersion();
    if (version>5.0) {
        UIImage * image=[[ThemeManager shareInstance]getThemeImage:@"navigationbar_background.png"];

        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarStyleDefault];
    }else{
        //异步调用drawrect
        [self.navigationBar setNeedsDisplay];
    }

}
//通知

-(void)themeNotification:(NSNotification *) notification
{
    [self loadThemeImage];
    
}
//清除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
@end
