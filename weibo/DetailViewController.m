//
//  DetailViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-27.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "WeiboView.h"
#import "CommentModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"微博正文";
    }
    return self;
}




- (void)viewDidLoad
{
    
    NSLog(@"lastid%@",[_weiboModel.weiboId stringValue]);
    [super viewDidLoad];
    
    [self _initView];
    
    NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
    
    [params setObject:[_weiboModel.weiboId stringValue] forKey:@"id"];
    
    [self loaddata:params];
    
    _isrefresh=NO;
    
    _ismore=NO;
    
    _tableView.refreshHeader=NO;
    //记得代理
    _tableView.eventDelegate=self;


}

-(void)_initView
{
    
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    
    headView.backgroundColor=[UIColor clearColor];
    
    [headView addSubview:_headBarView];
    
    _userImageView.layer.cornerRadius=5;
    _userImageView.layer.masksToBounds=YES;
    
    
    NSString * imagePath=_weiboModel.user.profile_image_url;
    
    if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
        
        
        [_userImageView setImageWithURL:[NSURL URLWithString:imagePath]];
    }
    
    
    _nickNameLabel.text=_weiboModel.user.screen_name;

    
    headView.height+=60;
    
    float h=[WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:YES];
    
    
    WeiboView * weiView=[[WeiboView alloc]initWithFrame:CGRectMake(10, _headBarView.bottom+10, ScreenWidth-20, h)];
    
    weiView.isDetail=YES;
    
    weiView.weiboModel=_weiboModel;
    
    
    headView.height+=h+10;

    
    [headView addSubview:weiView];
    
    
    self.tableView.tableHeaderView=headView;
    

}


//网络加载失败
- (void)request:(SinaWeiboRequest *)_request didFailWithError:(NSError *)error
{
    NSLog(@"网络加载失败");
}

//网络加载完成
- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{
    
    NSArray *comments = [result objectForKey:@"comments"];
    
    
    NSMutableArray *cs = [NSMutableArray arrayWithCapacity:comments.count];
    
    
    for (NSDictionary *commentsDic in comments) {
        
        CommentModel *comment = [[CommentModel alloc] initWithDataDic:commentsDic];
        
        [cs addObject:comment];
        
    }
    
    if (comments!=nil&&comments.count>0) {
        
        CommentModel *top_weibo =[cs objectAtIndex:0];
        
        self.topId=[top_weibo.id stringValue];
        
        CommentModel *down_weibo =[cs objectAtIndex:comments.count-1];
        
        self.downId=[down_weibo.id stringValue];
        
    }
    
    NSLog(@"comments.count %d",comments.count);
    
    if (comments.count<[WeiboSize intValue]) {
        
        self.tableView.islast=YES;
        
    }else{
        
        self.tableView.islast=NO;
        
        
    }

    
//    if (_isrefresh) {
//        
//        [cs addObjectsFromArray:self.comments];
//        
//        [self.tableView doneLoadingTableViewData];
    
//         self.comments=cs;
//    }
    
    //普通加载
    
    if(!_ismore&&!_isrefresh)      self.comments=cs;
    
    
    
    if (_ismore) {
        
        
        [_tableView stopload];
        
        [self.comments addObjectsFromArray:cs];
        
        [self.tableView doneLoadingTableViewData];
    }

    
   
    self.tableView.data=self.comments;
    
    //记得刷新
    [self.tableView reloadData];
    
    
}
#pragma mark loaddata
-(void)loaddata:(NSMutableDictionary *)params
{

        
        if(self.sinaweibo.isAuthValid){
            
            [self.sinaweibo requestWithURL:@"comments/show.json" params:params httpMethod:@"GET" delegate:self];
            
        }
    
    
    
}

#pragma mark UITableViewEventDelegate
-(void)pullDown:(BaseTableView *)tableView
{
    
    if([_weiboModel.commentsCount intValue]>0){
    
        _isrefresh=YES;
        
        _ismore=NO;
        
        
        NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
        
        
        if (self.topId!=nil) {
            [params setObject:self.topId forKey:@"since_id"];
            [params setObject:[_weiboModel.weiboId stringValue] forKey:@"id"];
            
        }
        
        
        [self loaddata:params];
    
    }
    
    
    
}
-(void)pullUp:(BaseTableView *)tableView
{
    
    
     if([_weiboModel.commentsCount intValue]>0){
         
    _ismore=YES;
    
    _isrefresh=NO;
    
    
    NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];

    if (self.downId!=nil) {
        [params setObject:self.downId forKey:@"max_id"];
        [params setObject:[_weiboModel.weiboId stringValue] forKey:@"id"];

    }
    
    
    [self loaddata:params];
     }
    
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
