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
#import "UiFactory.h"
#import "ThemeButton.h"
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
-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    
    if (self.requests!=nil&&self.requests.count>0) {
       
        for(SinaWeiboRequest * request in self.requests)
    
            [request disconnect];
        
    };


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ThemeButton * but=  [UiFactory createbackButton:@"tabbar_home.png" BackhighImage:@"tabbar_home_highlighted"];
    
    but.frame=CGRectMake(0, 0, 30, 30);
    
    [but addTarget:self action:@selector(gohome) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * baritem=[[UIBarButtonItem alloc]initWithCustomView:but];
    
    self.navigationItem.rightBarButtonItem=baritem;

    
    self.userinfoView=[[UserinfoView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    _tableView.eventDelegate=self;
    
        [self loadUserinfo];
    
    [self loadWeibo:@"100"];
    
}

-(void)gohome
{
    //返回到根控制器,也就是homeController
    [self.navigationController popToRootViewControllerAnimated:YES];

}

//加载用户微博
-(void)loadWeibo:(NSString *)tag
{

    //100 正常  101下拉刷新  102更多
    
    if (_userId!=nil&&_userId.length>0) {
        
        //接口升级之后不能获取别的用户
        //NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:_userId forKey:@"screen_name"];
        
     
        //记忆的天空699 威什么要名字呢
//        NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:@"威什么要名字呢" forKey:@"screen_name"];
        
      NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:@"2078894751" forKey:@"uid"];
        
        
        [params setObject:WeiboSize forKey:@"count"];
        
        if ([tag intValue]==101&&_topId!=nil) {
            [params setObject:self.topId forKey:@"since_id"];
        }
        
        
        if ([tag intValue]==102&&_downId!=nil) {


           [params setObject:_downId forKey:@"max_id"];
        
        }
        
        if(self.sinaweibo.isAuthValid){
            
            
      SinaWeiboRequest * request=[self.sinaweibo requestWithTAG:@"statuses/user_timeline.json" params:params httpMethod:@"GET" tag:@"101" delegate:self];
            
            [self.requests addObject:request];

        }
    }



}
//加载用户资料
-(void)loadUserinfo
{

    if (_userId!=nil&&_userId.length>0 ) {
        
       NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:_userId forKey:@"uid"];

        if(self.sinaweibo.isAuthValid){
            
            
           SinaWeiboRequest * request= [self.sinaweibo requestWithTAG:@"users/show.json" params:params httpMethod:@"GET" tag:@"104" delegate:self];
             [self.requests addObject:request];
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
