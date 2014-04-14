//
//  FriendshipViewController.h
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendshipTableView.h"
@interface FriendshipViewController : BaseViewController

@property(nonatomic,copy)NSString * uid;//用户id

@property(nonatomic,retain)NSMutableArray * data;
@property (weak, nonatomic) IBOutlet FriendshipTableView *tableView;
@end
