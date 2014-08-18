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
    
    Name=[[UILabel alloc] init];
    Name.frame=CGRectMake(12, 0, 200, 30);
    Name.backgroundColor=[UIColor clearColor];
    Name.textColor=[UIColor blackColor];
    Name.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    Name.text=@"为什么要名字呢";
    Name.hidden=YES;

    [self.view addSubview:Name];
    
    
    _tableView.hidden=YES;


        //[super showloading:YES];
    
    if(self.sinaweibo.isAuthValid){
    
     [self load_new_weibo:@"100"];
        
    }else{
    
        [self bindAction:nil];
    }
    
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
    if (statues.count>0&&[_request.tag intValue]!=102) {
        [self showUpdateCount:statues.count];
        
    }
    
    
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
    
    
    for (NSDictionary *statuesDic in statues) {
        
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
        
        [weibos addObject:weibo];
        
    }
    
    if ([_request.tag intValue]==102) {
        
        if (statues.count<[WeiboSize intValue]) {
            
            self.tableView.islast=YES;
            
        }else{
            
            self.tableView.islast=NO;
            
            
        }
    }
    
 

    if (weibos!=nil&&weibos.count>0) {
        
        WeiboModel *top_weibo =[weibos objectAtIndex:0];
        
        self.topId=[top_weibo.weiboId stringValue];
        
        WeiboModel *down_weibo =[weibos objectAtIndex:weibos.count-1];
        
        self.downId=[down_weibo.weiboId stringValue];
        
        
    }
    switch ([_request.tag intValue]) {
        case 100:
        self.weibos=weibos;
        break;
        case 101:
        [weibos addObjectsFromArray:self.weibos];
        
        [self.tableView doneLoadingTableViewData];
        
        self.weibos=weibos;
        break;
        case 102:
        [_tableView stopload];
        
        //去掉第一条重复微博
        [weibos removeObjectAtIndex:0];
        
        [self.weibos addObjectsFromArray:weibos];
        
        [self.tableView doneLoadingTableViewData];
        break;
        case 104:
        
        [weibos addObjectsFromArray:self.weibos];
        [self.tableView doneLoadingTableViewData];

        self.weibos=weibos;
        break;
        default:
        break;
    }
    
    
    self.tableView.data=self.weibos;

    //记得刷新
    [self.tableView reloadData];


}
#pragma mark loaddata
//加载新微博
-(void)load_new_weibo:(NSString *)tag
{
    //100  普通加载
    //101  下拉刷新
    //102  更多
    //104  tarbar点击
    
    if (tag == nil) {
        tag=@"100";
    }
    
    if(tag != nil&&[tag intValue]==100) [super showhud];
    
    if(self.sinaweibo.isAuthValid){
        
        NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
        
        if ([tag intValue]==101&&_topId!=nil) {
            [params setObject:self.topId forKey:@"since_id"];
        }
        
        
        if ([tag intValue]==102&&_downId!=nil) {
            
            [params setObject:_downId forKey:@"max_id"];
            
        }
        
        if ([tag intValue]==104&&_topId!=nil&&[_n_count intValue]>0) {
            
            [params setObject:_topId forKey:@"since_id"];
            
            [params setObject:_n_count forKey:@"count"];
            
            NSLog(@"%@",params);
            
            NSLog(@"hello");
                    
        }
        if(self.sinaweibo.isAuthValid){
            
            
            [self.sinaweibo requestWithTAG:@"statuses/home_timeline.json" params:params httpMethod:@"GET" tag:tag delegate:self];
            
        }
        
    }
    
    



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

//tarbar点击调用
-(void)pullDown:(BaseTableView *)tableView noread_count:(NSString *)n_count
{
    if (n_count!=nil&&n_count.length>0) {
        _n_count=n_count;
        
        [self load_new_weibo:@"104"];
    }
}

#pragma mark showDDmenu

-(void)showMenu:(BOOL) show
{

    MYAppDelegate *delegate = (MYAppDelegate *)[UIApplication sharedApplication].delegate;
    
    DDMenuController * menu=delegate.menu;
    
    [menu setEnableGesture:show];

}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self showMenu:YES];

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self showMenu:NO];
}
#pragma mark UITableViewEventDelegate
-(void)pullDown:(BaseTableView *)tableView
{
    [self load_new_weibo:@"101"];

    
}

-(void)pullUp:(BaseTableView *)tableView
{

    
    [self load_new_weibo :@"102"];
}

-(void)refreshWeibo:(NSString *)n_count{
    
    //使ui下拉
    [_tableView auto_refresh];
    
    //取数据
    
    [self pullDown:_tableView noread_count:n_count];
    
    

}
//向下滑动

-(void)SwipeDown:(BaseTableView *)tableView
{
    
//    Name.hidden=NO;

}
//向上滑动
-(void)SwipeUp:(BaseTableView *)tableView
{
   
//    Name.hidden=YES;

}


- (void)gotoDetail:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController * detail=[[DetailViewController alloc]init];
    
    detail.weiboModel=[self.weibos objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
