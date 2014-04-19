//
//  UserViewController.h
//  weibo
//
//  Created by laijiawei on 14-3-31.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "UserinfoView.h"
#import "WeiboTableView.h"
@interface UserViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewEventDelegate>
{
    
   
    
}
@property (weak, nonatomic) IBOutlet WeiboTableView *tableView;

@property(nonatomic,retain) UserinfoView * userinfoView;

@property(nonatomic,copy) NSString * userId;


@property(nonatomic,copy)NSString * topId;     //最大的id

@property(nonatomic,copy)NSString * downId;     //最小的id


@property(nonatomic,retain)NSMutableArray * weibos;  //保存所有的数据
@end
