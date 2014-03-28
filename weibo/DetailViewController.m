//
//  DetailViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-27.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "WeiboView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"微博正文";
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"detail");
    [self _initView];

}

-(void)_initView
{
    
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    
    headView.backgroundColor=[UIColor clearColor];
    
    [headView addSubview:_headBarView];
    
    _userImageView.layer.cornerRadius=5;
    _userImageView.layer.masksToBounds=YES;
    
    
    NSString * imagePath=_weiboModel.user.profile_image_url;
    
    if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
        
        
        [_userImageView setImageWithURL:[NSURL URLWithString:imagePath]];
    }
    
    
    _nickNameLabel.text=_weiboModel.user.screen_name;

    
    headView.height+=60;
    
    float h=[WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:YES];
    
    
    WeiboView * weiView=[[WeiboView alloc]initWithFrame:CGRectMake(10, _headBarView.bottom+10, ScreenWidth-20, h)];
    
    weiView.isDetail=YES;
    
    weiView.weiboModel=_weiboModel;
    
    
    headView.height+=h+10;

    
    [headView addSubview:weiView];
    
    
    self.tableView.tableHeaderView=headView;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
