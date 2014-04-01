//
//  UserViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-31.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "UserViewController.h"
#import "UserinfoView.h"
#import "WeiboModel.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"个人资料";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.userinfoView=[[UserinfoView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    _tableView.eventDelegate=self;
    
        [self loadUserinfo];
    
    [self loadWeibo:@"100"];
    
}
//加载用户微博
-(void)loadWeibo:(NSString *)tag
{

    //100 正常  101下拉刷新  102更多
    
    if (_userName!=nil&&_userName.length>0) {
        
        //接口升级之后不能获取别的用户
        //NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:_userName forKey:@"screen_name"];
        
     
        
        NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:@"威什么要名字呢" forKey:@"screen_name"];
        
        [params setObject:WeiboSize forKey:@"count"];
        
        if ([tag intValue]==101&&_topId!=nil) {
            [params setObject:self.topId forKey:@"since_id"];
        }
        
        
        if ([tag intValue]==102&&_downId!=nil) {


           [params setObject:_downId forKey:@"max_id"];
        
        }
        
        if(self.sinaweibo.isAuthValid){
            
            
            [self.sinaweibo requestWithTAG:@"statuses/user_timeline.json" params:params httpMethod:@"GET" tag:@"101" delegate:self];

        }
    }



}
//加载用户资料
-(void)loadUserinfo
{

    if (_userName!=nil&&_userName.length>0) {
        
        NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:_userName forKey:@"screen_name"];
        
        
        if(self.sinaweibo.isAuthValid){
            
            
            [self.sinaweibo requestWithTAG:@"users/show.json" params:params httpMethod:@"GET" tag:@"104" delegate:self];
        }
    }
 
    


}
//网络加载失败
- (void)request:(SinaWeiboRequest *)_request didFailWithError:(NSError *)error
{
    NSLog(@"网络加载失败");
}

//网络加载完成
- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{
    
    if ([_request.tag intValue]==104) {
        UserModel * model=[[UserModel alloc]initWithDataDic:result];
        
        self.userinfoView.userModel=model;
        
        //请求完成再赋值
        _tableView.tableHeaderView=self.userinfoView;
    }else{
    
    NSArray *statues = [result objectForKey:@"statuses"];
    
    
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    
    
    for (NSDictionary *statuesDic in statues) {
        
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        
        [weibos addObject:weibo];
        
    }

    
    if (statues.count<[WeiboSize intValue]) {
        
        self.tableView.islast=YES;
        
    }else{
        
        self.tableView.islast=NO;
    
    }
    
    if (weibos!=nil&&weibos.count>0) {
        
        WeiboModel *top_weibo =[weibos objectAtIndex:0];
        
        self.topId=[top_weibo.weiboId stringValue];
        
        WeiboModel *down_weibo =[weibos objectAtIndex:weibos.count-1];
        
        self.downId=[down_weibo.weiboId stringValue];
        
        
    }
    
    //下拉
    if ([_request.tag intValue]==101) {
        
        [weibos addObjectsFromArray:self.weibos];
        
        [self.tableView doneLoadingTableViewData];
        
        self.weibos=weibos;
    }
    
    //更多
    if ([_request.tag intValue]==102) {
        
        
        [_tableView stopload];
        
        //去掉第一条重复微博
        [weibos removeObjectAtIndex:0];
        
        [self.weibos addObjectsFromArray:weibos];
        
        [self.tableView doneLoadingTableViewData];
        
    }
    
    //普通加载
    
    if([_request.tag intValue]==100)      self.weibos=weibos;
    
    
    self.tableView.data=self.weibos;
    
    //记得刷新
    [self.tableView reloadData];
    
    }

  
}


#pragma mark UITableViewEventDelegate
-(void)pullDown:(BaseTableView *)tableView
{

    
    NSLog(@"hello");
    
    
    [self loadWeibo:@"101"];
    
}

-(void)pullUp:(BaseTableView *)tableView
{
    
    [self loadWeibo:@"102"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end