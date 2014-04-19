//
//  FriendshipViewController.h
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendshipTableView.h"


typedef NS_ENUM(NSInteger,friendtype ) {
    Fans=0,
    Att=1
} ;


@interface FriendshipViewController : BaseViewController<UITableViewEventDelegate>

@property(nonatomic,copy)NSString * uid;//用户id

@property(nonatomic,retain)NSMutableArray * data;

@property(nonatomic,assign)friendtype * type;

@property(nonatomic,retain) FriendshipTableView *tableView;


@property(nonatomic,retain) NSString *next_cursor;

@end
