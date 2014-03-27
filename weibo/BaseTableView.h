//
//  BaseTableView.h
//  weibo
//
//  Created by laijiawei on 14-3-23.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class BaseTableView;

@protocol UITableViewEventDelegate <NSObject>
@optional

-(void)pullDown:(BaseTableView *)tableView; //下拉刷新

-(void)pullUp:(BaseTableView *)tableView;  //加载更多


@end



@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{

    EGORefreshTableHeaderView *_refreshHeaderView;

    BOOL _reloading;
    
    UIButton * _more;    //加载更多
    
    UIActivityIndicatorView *_activityView; //风火轮

}

@property(nonatomic,assign)BOOL refreshHeader;  //是否需要下拉

@property(nonatomic,assign)BOOL islast;  //是否是最后一页


@property(nonatomic,retain)NSArray * data;   //数据源



@property(nonatomic,assign) id<UITableViewEventDelegate>  eventDelegate;

- (void)doneLoadingTableViewData;

-(void)startload;

-(void)stopload;

-(void)auto_refresh;

    

@end
