//
//  MessageViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "MessageViewController.h"
#import "faceView.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title=@"消息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    faceView * view=[[faceView alloc]initWithFrame:CGRectZero];
    
    UIScrollView *sview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, 320, 260)];
    
    sview.backgroundColor=[UIColor grayColor];

    sview.contentSize=CGSizeMake(view.width, view.height);
    
    sview.pagingEnabled=YES;
    
    [sview addSubview:view];
    
    
    [self.view addSubview:sview];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
