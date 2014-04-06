//
//  MYAppDelegate.m
//  weibo
//
//  Created by laijiawei on 14-3-15.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "MYAppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SinaWeibo.h"
#import "CONSTS.h"
#import "ThemeManager.h"
@implementation MYAppDelegate

  //初始化新浪微博
-(void)_initSinaWeibo{

    
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_main];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }



}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    



   //注意加载顺序
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    //加载主题
    [ThemeManager shareInstance].themeName=[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
    
     _main=[[MainViewController alloc]init];


    _menu=[[DDMenuController alloc]initWithRootViewController:_main];
    
    LeftViewController *left=[[LeftViewController alloc]init];
    RightViewController *right=[[RightViewController alloc]init];
    
    _menu.leftViewController=left;
    _menu.rightViewController=right;
    
    [self _initSinaWeibo];
    
    self.window.rootViewController=_menu;

    [_menu release];
    
    return YES;
}
							
@end
