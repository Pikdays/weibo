//
//  HomeViewController.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"
#import "ThemeImageView.h"

@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewEventDelegate>
{


    ThemeImageView * barView;

}
@property (nonatomic, retain) WeiboTableView *tableView;

@property(nonatomic,copy)NSString * topId;     //最大的id

@property(nonatomic,copy)NSString * downId;     //最小的id


@property(nonatomic,retain)NSMutableArray * weibos;  //保存所有的数据

@property(nonatomic,assign)BOOL isrefresh;          //判断是否是下拉刷新操作

@property(nonatomic,assign)BOOL ismore;          //判断是否加载更多

-(void)refreshWeibo;

-(void)load_new_weibo:(NSMutableDictionary *)params;



@end
