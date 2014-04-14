//
//  MessageViewController.h
//  weibo
//消息首页控制器
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"

@interface MessageViewController : BaseViewController<UITableViewEventDelegate>


@property(nonatomic,copy)NSString * topId;     //最大的id

@property(nonatomic,copy)NSString * downId;     //最小的id

@property(nonatomic,retain)NSMutableArray * weibos;  //保存所有的数据

@property(nonatomic,retain)WeiboTableView * tableView;


@end
