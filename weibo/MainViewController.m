//
//  MainViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "MainViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "UiFactory.h"
#import "UserViewController.h"
#import "MYAppDelegate.h"
#import "UiFactory.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [self _initViewController];
    
    [self _initTabbarView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化子控制器
-(void)_initViewController
{

     HomeViewController * home=[[HomeViewController alloc]init];
     MessageViewController * message=[[MessageViewController alloc]init];
     UserViewController * user=[[UserViewController alloc]init];
     DiscoverViewController * discover=[[DiscoverViewController alloc]init];
     MoreViewController * more=[[MoreViewController alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    user.userId=[sinaweiboInfo objectForKey:@"UserIDKey"];
    
    
    _views=@[home,message,user,discover,more];
    
    NSMutableArray * viewControllers=[NSMutableArray arrayWithCapacity:5];
    
    for (UIViewController * view in _views) {
        BaseNavigationController * nav=[[BaseNavigationController alloc]initWithRootViewController:view];
        [viewControllers addObject:nav];
        nav.delegate=self;
    }
    
    self.viewControllers=viewControllers;
    
    
    _noread_count=@0;
    
    //每60秒加载未读微博的数目

    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(loadNoReadData) userInfo:nil repeats:YES];
    

    
    
}

//创建自定义Tabbar
-(void)_initTabbarView{


    
    
    _tabbarView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49-20, ScreenWidth, 49)];
//
//    //定义背景颜色,来自图片
  //  _tabbarView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    [self.view addSubview:_tabbarView];

    UIImageView * backview=[UiFactory createImageView:@"tabbar_background.png"];
    
    backview.frame=_tabbarView.bounds;
    
    [_tabbarView addSubview:backview];
    
    

    
    NSArray * backgroup=@[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    NSArray * highlightedBackgroup=@[@"tabbar_home_highlighted.png",
                                     @"tabbar_message_center_highlighted.png",
                                     @"tabbar_profile_highlighted.png",
                                     @"tabbar_discover_highlighted.png",
                                     @"tabbar_more_highlighted.png"];
    for (int i=0; i<[backgroup count]; i++) {
        
        NSString * backImage=[backgroup objectAtIndex:i];
        NSString * highlightbackImage=[highlightedBackgroup objectAtIndex:i];
        
        //UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        //ThemeButton * but=[[ThemeButton alloc]initWithImage:backImage highImage:highlightbackImage];
        
        UIButton * but=[UiFactory createButton:backImage highImage:highlightbackImage];
        
        
        //相对父视图
        but.frame=CGRectMake((64-30)/2+i*64,(49-30)/2, 30,30);
        but.tag=i;
//        [but setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
//        [but setBackgroundImage:[UIImage imageNamed:highlightbackImage] forState:UIControlStateHighlighted];
        
        [but addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:but];
    }
    
    _sliderView=[UiFactory createImageView:@"tabbar_slider.png"];
    _sliderView.frame=CGRectMake((64-15)/2, 5, 15, 44);

    [_tabbarView addSubview:_sliderView];
    

}

-(void)selectedTab:(UIButton *) button
{

//    _sliderView.frame=CGRectMake(64*but.tag+(64-15)/2, 5, 15, 44);
    
    float x = button.left + (button.width-_sliderView.width)/2;
    
    [UIView animateWithDuration:0.2 animations:^{
       // _sliderView.frame=CGRectMake(64*button.tag+(64-15)/2, 5, 15, 44);
        _sliderView.left=x;

    }];


    if (self.selectedIndex==button.tag&&button.tag==0) {

        HomeViewController * home=[_views objectAtIndex:0];
        [home refreshWeibo:[self.noread_count stringValue]];
    }
    self.selectedIndex=button.tag;


}
//控制未读视图是否显示
-(void)shownoread:(BOOL)show{

    _noreadView.hidden=!show;

}

#pragma  mark - SinaWeiboDelegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    
    
    //保存认证信息
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    //登陆完成加载微博列表
    HomeViewController * home=  [self.views objectAtIndex:0];
    
    [home load_new_weibo:nil];
    
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    //移除认证信息
 [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{




}

//更新未读数据
-(void)loadNoReadData
{
    
    MYAppDelegate *delegate = (MYAppDelegate *)[UIApplication sharedApplication].delegate;
    
    SinaWeibo * sinaweibo=delegate.sinaweibo;


    if(sinaweibo.isAuthValid){
        
        [sinaweibo requestWithURL:@"remind/unread_count.json" params:nil httpMethod:@"GET" delegate:self];
        
    }
    
}

- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{

    NSDictionary *statues=result;
    
    _noread_count=[statues objectForKey:@"status"];
    
   // _noread_count=[[NSNumber alloc]initWithInt:55];
    
    [self loadNoReadView:_noread_count];
    

}
//更新未读视图
-(void)loadNoReadView:(NSNumber*)noread_count
{

    if (_noreadView==nil) {
        
        
        _noreadView=[UiFactory createImageView:@"main_badge.png"];
        
        
        _noreadView.frame=CGRectMake(64-25, 5, 20, 20);
        
        [_tabbarView addSubview:_noreadView];
        
        UILabel * noreadLabel=[[UILabel alloc]initWithFrame:_noreadView.bounds];
        
        noreadLabel.backgroundColor=[UIColor clearColor];

        noreadLabel.tag=100;
        
        noreadLabel.textAlignment=NSTextAlignmentCenter;
        
       // noreadLabel.backgroundColor=[UIColor purpleColor];
        
        noreadLabel.font=[UIFont boldSystemFontOfSize:13.0f];
        
        [_noreadView addSubview:noreadLabel];

        
    }
    
    if ([noread_count intValue]>0) {
        
        UILabel * noreadLabel=(UILabel *)[_noreadView viewWithTag:100];
        
        noreadLabel.text=[noread_count stringValue];
        
        _noreadView.hidden=NO;

        
    }else{
        
        _noreadView.hidden=YES;
        
    }



}
-(void)showtabbarView:(BOOL)show{

    [UIView animateWithDuration:0.35 animations:^{
    
        if (show) {
            _tabbarView.left=0;
        }else{
            _tabbarView.left=-ScreenWidth;

        }
        
    
    }];
    
    [self _resizeView:show];

   

}
#pragma mark -UI

//修改内容视图高度
-(void)_resizeView:(BOOL) showtarbar
{

    for(UIView * view in self.view.subviews){
    
        if([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
        
            if (showtarbar) {
                view.height=ScreenHeight-49-20;
            }else{
                view.height=ScreenHeight-20;
                
            }
        
        }
    }


}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

    int count=navigationController.viewControllers.count;
    
    if (count>1) {

        [self showtabbarView:NO];
    }else{
        [self showtabbarView:YES];
    
    }


}

@end
