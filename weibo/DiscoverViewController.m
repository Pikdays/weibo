//
//  DiscoverViewController.m
//  weibo
//广场
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearbyWeiboViewController.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"广场";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i=100; i<102; i++) {
        
        UIButton * but=(UIButton *)[self.view viewWithTag:i];
        but.layer.shadowColor=[UIColor blackColor].CGColor;
        but.layer.shadowOffset=CGSizeMake(3, 3);
        but.layer.shadowOpacity=1;
        but.layer.shadowRadius=3;
    }

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nearweibo_click:(UIButton *)sender {
    
    NearbyWeiboViewController * nav=[[NearbyWeiboViewController alloc]init];
    
    [self.navigationController pushViewController:nav animated:YES];
}
- (IBAction)nearperson_click:(UIButton *)sender {

    
}
@end
