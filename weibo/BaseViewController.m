//
//  BaseViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "MYAppDelegate.h"
#import "UiFactory.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton=YES;
        self.isCancelButton=NO;
        self.requests=[NSMutableArray array];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray * ctrls=self.navigationController.viewControllers;
    
 
    //更改自定义的返回按钮
        if (ctrls.count>1&&_isBackButton==YES) {
        
        UIButton * but=[UiFactory createButton:@"navigationbar_back.png" highImage:@"navigationbar_back_highlighted.png"];
 
        but.frame=CGRectMake(0, 0, 24, 24);
        
        [but addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:but];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:but];
        
     }
    
    if (_isCancelButton) {
        
        UIButton * cancelbut=[UiFactory createNavButton:CGRectMake(0, 0, 45, 30) title:@"取消" target:self action:@selector(CancelClick:)];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:cancelbut];
    }
    
    
}



-(void)CancelClick:(UIButton *)button
{

    [self disView];
}

//关闭弹出窗口
-(void)disView
{
    [self dismissViewControllerAnimated:YES completion:nil];//5.0之后
    
    //    [self dismissModalViewControllerAnimated:YES];5.0之前

}

//点击返回按钮
-(void)back:(UIButton *) button
{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//override
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectZero];
    
    label.text=title;
    label.textColor=[UIColor blackColor];
    label.font=[UIFont boldSystemFontOfSize:18.0f];
    label.backgroundColor=[UIColor clearColor];
    [label sizeToFit];
    self.navigationItem.titleView=label;
    
}




- (SinaWeibo *)sinaweibo
{
    MYAppDelegate *delegate = (MYAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

//是否显示正在加载页面

-(void)showloading:(BOOL)show{

    if (self.loadingView==nil) {
        
        self.loadingView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2-80, ScreenWidth, 20)];
        
        //风火轮
     UIActivityIndicatorView   * activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [activityView startAnimating];

        //正在加载label
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectZero];
        label.backgroundColor=[UIColor clearColor];
        label.text=@"正在加载";
        label.font=[UIFont boldSystemFontOfSize:16.0];
        label.textColor=[UIColor blackColor];
        [label sizeToFit];
        
        label.left=(ScreenWidth-label.width)/2;
        activityView.left=label.left-20;
        [self.loadingView addSubview:activityView];
        [self.loadingView addSubview:label];
    }
    
    if (show) {
            if(![self.loadingView superview])
            {
            [self.view addSubview:self.loadingView];
            }
    }else{
    
        [self.loadingView removeFromSuperview];
    }

}

-(void)showhud
{

    self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];

    //self.hud.dimBackground=YES;
    
    self.hud.labelText=@"正在加载";

}

-(void)hidehud
{

    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
-(void)showhud_custom:(NSString *)title
{

    self.hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];

    self.hud.mode=MBProgressHUDModeCustomView;
    
    self.hud.labelText=title;
    
    [self.hud hide:YES afterDelay:1];
}

//状态栏显示
-(void)showStatusView:(BOOL)show title:(NSString *)title
{


    if (_tipwindow==nil) {
        
        _tipwindow=[[UIWindow alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        
        _tipwindow.windowLevel=UIWindowLevelStatusBar;
        
        _tipwindow.backgroundColor=[UIColor blackColor];
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        
        label.font=[UIFont systemFontOfSize:13];
        
        label.backgroundColor=[UIColor clearColor];
        
        label.textAlignment=NSTextAlignmentCenter;
        
        label.textColor=[UIColor whiteColor];
        
        label.tag=101;
        
        [_tipwindow addSubview:label];
        
        UIImageView * process=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20-6, 100, 6)];
        
        [process setImage:[UIImage imageNamed:@"queue_statusbar_progress.png"]];
        
        process.tag=102;
        
        [_tipwindow addSubview:process];
        
    }

    UILabel * label=[_tipwindow  viewWithTag:101];
    
    label.text=title;
    
    UIImageView *process=[_tipwindow viewWithTag:102];

    
    if (show) {
        
        _tipwindow.hidden=NO;
        process.left=0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationRepeatCount:1000];//重复次数
        [UIView setAnimationDuration:2];//时间
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];//速度
        process.left=ScreenWidth;
        [UIView commitAnimations];
        

    }else{
        
        process.hidden=YES;
        
        [self performSelector:@selector(disWindow) withObject:nil afterDelay:1.5];
    
    }


}

-(void)disWindow
{
    _tipwindow.hidden=YES;

    _tipwindow=nil;
}

@end
