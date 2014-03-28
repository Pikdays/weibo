//
//  HomeViewController.m
//  weibo

// 首页控制器

//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboModel.h"
#import "UiFactory.h"
#import "MainViewController.h"
#import "DetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"微博";
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //绑定按钮
    UIBarButtonItem *bindItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(bindAction:)];
    self.navigationItem.rightBarButtonItem = [bindItem autorelease];
    
    //注销按钮
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction:)];
    self.navigationItem.leftBarButtonItem = [logoutItem autorelease];
    
    self.tableView=[[WeiboTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-49-44) style:UITableViewStylePlain];
    
    _tableView.eventDelegate=self;
    
    
    
    
    [self.view addSubview:self.tableView];
    
    

    _isrefresh=NO;
    
    _ismore=NO;
    
    _tableView.hidden=YES;
    
    //[super showloading:YES];

    [super showhud];
    
    [self load_new_weibo:nil];
    
}



#pragma mark ui
-(void)showUpdateCount:(int)count
{
    
    if (barView==nil) {
        
        barView=[UiFactory createImageView:@"timeline_new_status_background.png"];
        
        //隐藏
        barView.frame=CGRectMake(5,-40, ScreenWidth-10, 40);
        
        UIImage *image=[barView.image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
        barView.image=image;
        
        barView.leftCapWidth=5;
        
        barView.topCapHeight=5;
        
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectZero];
        
        label.tag=200;
        
        label.backgroundColor=[UIColor clearColor];
        
        label.textColor=[UIColor whiteColor];
        
        label.font=[UIFont  systemFontOfSize:16.0];


        
        [barView addSubview:label];
        
        [self.view addSubview:barView];
      
        
    }
    
    UILabel * label=[barView viewWithTag:200];
    
    
    label.text=[NSString stringWithFormat:@"%d条新微博",count];
    
    [label sizeToFit];
    
    label.origin=CGPointMake((barView.width-label.width)/2, (barView.height-label.height)/2);

    
    [UIView animateWithDuration:0.5 animations:^{
    
        barView.top=5;
    
    } completion:^(BOOL finish){
    
        if (finish) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:1];
            [UIView setAnimationDuration:0.6];
            barView.top=-40;
            [UIView commitAnimations];
        }
    
    }];


    MainViewController * main= self.tabBarController;
    //隐藏未读视图
    [main shownoread:NO];

}
#pragma mark - SinaWeiboRequest Delegate

//网络加载失败
- (void)request:(SinaWeiboRequest *)_request didFailWithError:(NSError *)error
{
    NSLog(@"网络加载失败");
}

//网络加载完成
- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{
    
    //[super showloading:NO];
    
   // [super hidehud];
    
    [ super showhud_custom:@"加载完成"];
    
    _tableView.hidden=NO;
    
    NSArray *statues = [result objectForKey:@"statuses"];
    
    //显示更新的数据数目
    if (statues.count>0&&!_ismore) {
        [self showUpdateCount:statues.count];
        
    }
    
    
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    
    
    for (NSDictionary *statuesDic in statues) {
        
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        
        [weibos addObject:weibo];
        
    }
    
    
    if (statues.count<=5) {
    
        self.tableView.islast=NO;
        
    }else{
    
        self.tableView.islast=YES;

    
    }

    if (weibos!=nil&&weibos.count>0) {
        
        WeiboModel *top_weibo =[weibos objectAtIndex:0];
        
        self.topId=[top_weibo.weiboId stringValue];
        
        WeiboModel *down_weibo =[weibos objectAtIndex:weibos.count-1];
        
        self.downId=[down_weibo.weiboId stringValue];
        
        
    }
    
    if (_isrefresh) {
        
        [weibos addObjectsFromArray:self.weibos];
        
        [self.tableView doneLoadingTableViewData];
    }
    
    
    if (_ismore) {
        
        
        //[_tableView stopload];
        
        [self.weibos addObjectsFromArray:weibos];
        
        [self.tableView doneLoadingTableViewData];
    }
    
    
    self.weibos=weibos;
    
    self.tableView.data=weibos;

    //记得刷新
    [self.tableView reloadData];


}
#pragma mark loaddata
//加载新微博
-(void)load_new_weibo:(NSMutableDictionary *)params
{
    
    if (params==nil) {
        
        params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];

    }
    
    if(self.sinaweibo.isAuthValid){
        
        [self.sinaweibo requestWithURL:@"statuses/home_timeline.json" params:params httpMethod:@"GET" delegate:self];
        
    }
    
//    else{
//    
//        [self bindAction:nil];
//    }

}


#pragma  mark Actions

-(void)bindAction:(UIBarButtonItem * )item
{

    [self.sinaweibo logIn];
    

}


-(void)logoutAction:(UIBarButtonItem * )item
{
    
    
    [self.sinaweibo logOut];
    
}

#pragma mark UITableViewEventDelegate
-(void)pullDown:(BaseTableView *)tableView
{
    
    NSLog(@"self.topId%@",self.topId);
    _isrefresh=YES;
    
    _ismore=NO;
    
    

//    MainViewController * main= self.tabBarController;
//    if (main.noread_count!=nil&&[main.noread_count intValue]>0&&[main.noread_count intValue]<=[WeiboSize intValue]) {
//        
//        count=[main.noread_count stringValue];
//
//    }
    
    
    NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
    
    if (self.topId!=nil) {
        [params setObject:self.topId forKey:@"since_id"];
    }
    
    
    [self load_new_weibo:params];

    
    
}
-(void)pullUp:(BaseTableView *)tableView
{
    
    NSLog(@"pullup");
    
    NSLog(@"downId%@",self.downId);
    _ismore=YES;
    
    _isrefresh=NO;
    
    
    NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
    
    
    if (_downId) {
        [params setObject:_downId forKey:@"max_id"];
    }
    
    
    [self load_new_weibo:params];
    

}

-(void)refreshWeibo{
    
    
    //使ui下拉
    [_tableView auto_refresh];
    
    //取数据
    [self pullDown:_tableView];
    

}

- (void)gotoDetail:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController * detail=[[DetailViewController alloc]init];
    
    detail.weiboModel=[self.weibos objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
