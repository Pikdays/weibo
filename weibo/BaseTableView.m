//
//  BaseTableView.m
//  weibo
//
//  Created by laijiawei on 14-3-23.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {

        [self initView];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initView];

}
-(void)initView
{
	 _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.backgroundColor=[UIColor clearColor];
    
    _refreshHeaderView.delegate = self;
    
    
    self.dataSource=self;
    self.delegate=self;
    
    self.refreshHeader=YES;
    
    _more=[UIButton buttonWithType:UIButtonTypeCustom];
    _more.frame=CGRectMake(0, 0, ScreenWidth, 40);
    _more.backgroundColor=[UIColor clearColor];
    _more.titleLabel.font=[UIFont systemFontOfSize:16.0f];
    
    [_more setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_more setTitle:@"上拉加载更多..." forState :UIControlStateNormal];
    [_more addTarget:self action:@selector(loaddata) forControlEvents:UIControlEventTouchUpInside];
    
    //风火轮
    _activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityView stopAnimating];
    _activityView.frame=CGRectMake(100, 10, 20, 20);

    
    [_more addSubview:_activityView];
    
    
    self.tableFooterView=_more;

}
//重写，调用stopload
-(void)reloadData
{
    [super reloadData];
    [self stopload];

}

-(void)stopload{
    
    if (self.data.count>0) {
            
            [_activityView stopAnimating];
            
            [_more setTitle:@"上拉加载更多..." forState :UIControlStateNormal];
            
            _more.enabled=YES;
        
        if (_islast) {
            [_more setTitle:@"加载完成" forState :UIControlStateNormal];
            _more.enabled=NO;

        }
        _more.hidden=NO;
    
    }else{
            _more.hidden=YES;
    }
    
  
}

-(void)startload{
    
    [_activityView startAnimating];
    
    [_more setTitle:@"正在加载" forState:UIControlStateNormal];
    
    _more.enabled=NO;
}

-(void)loaddata
{
    [self startload];
    
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
        
    }
}

-(void)setRefreshHeader:(BOOL)refreshHeader
{
    _refreshHeader=refreshHeader;
    if (_refreshHeader) {
        [self addSubview:_refreshHeaderView];
    }else{
    
        //移除视图
        if ([_refreshHeaderView superview]) {
            [_refreshHeaderView removeFromSuperview];
        }
    
    }


}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.eventDelegate respondsToSelector:@selector(gotoDetail)]) {
        [self.eventDelegate gotoDetail];
        
    }
    
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}



#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
    
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];

    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //上拉刷新
    
    if (!_islast) {
        
        if (scrollView.contentSize.height-scrollView.contentOffset.y-scrollView.height<20) {
            [self loaddata];
        }

    }
    
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}




#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉到一定距离，手指放开时调用
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    //停止加载，弹回下拉
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];

    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    NSDate *date= [[NSUserDefaults standardUserDefaults]objectForKey:@"pullDate"];
    
    if (date==nil) {
        date=[NSDate date];
    }

    
    [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:@"pullDate"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
	return date;
	
}
//自动下拉刷新
-(void)auto_refresh{
    
    [_refreshHeaderView initLoading:self];
    
}
@end
