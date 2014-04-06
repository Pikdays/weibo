//
//  RightViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "RightViewController.h"
#import "BaseNavigationController.h"
#import "SendViewController.h"
#import "MYAppDelegate.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"右";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)butclick:(UIButton *)sender {
    
    NSInteger * tag=sender.tag;
    
    if (tag==100) {
        SendViewController * send=[[SendViewController alloc]init];
        BaseNavigationController * nav=[[BaseNavigationController alloc]initWithRootViewController:send];
      MYAppDelegate * delegate=  (MYAppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.menu presentViewController:nav animated:YES completion:nil];
    }
    
}
@end
