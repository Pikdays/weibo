//
//  MessageViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "MessageViewController.h"
#import "faceView.h"
#import "faceScrollView.h"
#import "UiFactory.h"
#import  "NetRequest.h"
#import "WeiboModel.h"
#import "DetailViewController.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title=@"消息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initView];
    

    //默认显示@我的微博
    [self loadAtrequest];

    

}

-(void)initView
{


    NSArray * images=[NSArray arrayWithObjects:@"navigationbar_mentions.png",
                      @"navigationbar_comments.png",
                      @"navigationbar_messages.png",
                      @"navigationbar_notice.png",
                      nil];
    
    UIView * titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    for (int i=0; i<images.count; i++) {
        
        UIButton * but=[UiFactory createButton:images[i] highImage:images[i]];
        but.showsTouchWhenHighlighted=YES;
        but.frame=CGRectMake(50*i+20, 10, 22, 22);
        but.tag=100+i;
        [but addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:but];
    }
    
 
    self.navigationItem.titleView=titleView;
    
    
    _tableView=[[WeiboTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-49-44) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];
    
    _tableView.hidden=YES;
    
    _tableView.eventDelegate=self;
    

}

-(void)loadAtrequest
{

    NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
    
    [super showhud];
    
    [NetRequest requestWithBlock:@"statuses/mentions.json" httpMethod:@"GET" params:params completeBlock:^(id result) {
        
        [ super showhud_custom:@"加载完成"];
        
        
        NSMutableArray *weibos=  [self loadAtData:result];
        
        
        _tableView.data=weibos;
        
        self.weibos=weibos;
        
        
        [_tableView reloadData];
        
        
    }];

}

-(void)butclick:(UIButton *)but
{

    if (but.tag==100) {
        
        [self loadAtrequest];

    }

}
//加载@微博
-(NSMutableArray *)loadAtData:(id)result
{
    
        _tableView.hidden=NO;
        
        NSArray *statues = [result objectForKey:@"statuses"];
    
    if (statues!=nil&&statues.count>0) {
    
        
        NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statues.count];
        
        
        for (NSDictionary *statuesDic in statues) {
            
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statuesDic];
            
            [weibos addObject:weibo];
            
        }
        
        if (weibos!=nil&&weibos.count>0) {
            
            WeiboModel *top_weibo =[weibos objectAtIndex:0];
            
            self.topId=[top_weibo.weiboId stringValue];
            
            WeiboModel *down_weibo =[weibos objectAtIndex:weibos.count-1];
            
            self.downId=[down_weibo.weiboId stringValue];
            
            
        }

        
  
        return weibos;
    
    
    }
    
    return nil;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewEventDelegate
-(void)pullDown:(BaseTableView *)tableView
{
    
    NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
    
    if (self.topId!=nil)  [params setObject:self.topId forKey:@"since_id"];

  
    
    [NetRequest requestWithBlock:@"statuses/mentions.json" httpMethod:@"GET" params:params completeBlock:^(id result) {
        
        [self.tableView doneLoadingTableViewData];

        
        [self loadAtData:result];
        
        NSMutableArray *weibos=  [self loadAtData:result];
        
        if (weibos!=nil) {
            
            [weibos addObjectsFromArray:self.weibos];
            
            
            self.weibos=weibos;
        }
        
        
        
        _tableView.data=self.weibos;
        
        [_tableView reloadData];

        
    }];

}

-(void)pullUp:(BaseTableView *)tableView
{

    NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:WeiboSize forKey:@"count"];
    
    
    if (self.downId!=nil) [params setObject:_downId forKey:@"max_id"];
    
    
    [NetRequest requestWithBlock:@"statuses/mentions.json" httpMethod:@"GET" params:params completeBlock:^(id result) {
        

        
        [self loadAtData:result];
        
        NSMutableArray *weibos=  [self loadAtData:result];
        
        
        
        if (weibos==nil || weibos.count<[WeiboSize intValue]) {
            
            self.tableView.islast=YES;
            
        }else{
            
            self.tableView.islast=NO;

        }
    
        
        
        
        if (weibos!=nil) {
            //去掉第一条重复微博
            [weibos removeObjectAtIndex:0];
            
            [self.weibos addObjectsFromArray:weibos];
            
            
        }
        
   

        self.tableView.data=self.weibos;
        
          [_tableView reloadData];
        
    }];



}

- (void)gotoDetail:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailViewController * detail=[[DetailViewController alloc]init];
    
    detail.weiboModel=[self.weibos objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
