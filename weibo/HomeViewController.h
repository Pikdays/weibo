//
//  HomeViewController.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "WeiboTableView.h"
#import "ThemeImageView.h"
#import "BaseViewController.h"
#import "MYAppDelegate.h"

@interface HomeViewController:BaseViewController<SinaWeiboRequestDelegate,UITableViewEventDelegate>
{


    ThemeImageView * barView;
    
    UILabel * Name;

}

@property (nonatomic, retain) WeiboTableView *tableView;

@property(nonatomic,copy)NSString * topId;     //最大的id

@property(nonatomic,copy)NSString * downId;     //最小的id

@property(nonatomic,copy)NSString * n_count;     //未读微博数

@property(nonatomic,retain)NSMutableArray * weibos;  //保存所有的数据


-(void)refreshWeibo:(NSString *)noread_count;

-(void)load_new_weibo:(NSMutableDictionary *)params;




@end
