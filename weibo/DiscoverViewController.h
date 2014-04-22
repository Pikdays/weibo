//
//  DiscoverViewController.h
//  weibo
//  广场
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"

@interface DiscoverViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *nearweibo;
- (IBAction)nearweibo_click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nearperson;
- (IBAction)nearperson_click:(UIButton *)sender;

@end
