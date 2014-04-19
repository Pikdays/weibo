//
//  FriendshipViewController.m
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "FriendshipViewController.h"
#import "NetRequest.h"
#import "UserModel.h"

#define FRIENDSIZE @"9"

@interface FriendshipViewController ()

@end

@implementation FriendshipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView=[[FriendshipTableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-20-44) style:UITableViewStylePlain];
    
    
    //这里为什么不能用[self.view addSubview:_tableView];
    self.view=_tableView;
    
   // [self.view addSubview:_tableView];
    

    
    _tableView.eventDelegate=self;
    
     _data=[NSMutableArray array];
    
    [self loadfriend];
    
}

-(void)loadfriend
{

    if (_uid!=nil&&_uid.length>0){
        
        NSString * url=nil;
        
        if (self.type==Fans) {
            
            url=@"friendships/followers.json";
            self.title=@"粉丝列表";

            
        }else if(self.type==Att){
            
            url=@"friendships/friends.json";
            self.title=@"关注列表";

            
        }
        
//        [self showhud];
        
        NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:_uid forKey:@"uid"];
        
        [params setObject:FRIENDSIZE forKey:@"count"];
        
        if (_next_cursor!=nil&&_next_cursor.length>0) [params setObject:_next_cursor forKey:@"cursor"];
        
        [NetRequest requestWithBlock:url httpMethod:@"GET" params:params completeBlock:^(id result) {
            
            [self loaddatafinish:result];
            
        }];
        
        
    }


}


-(void)loaddatafinish:(id)result
{

//    [ self showhud_custom:@"加载完成"];


    
   NSArray *users = [result objectForKey:@"users"];
    
    NSLog(@"%d",users.count);
    
    NSMutableArray *array2D=nil;
    
    for (int i=0; i<users.count; i++) {
        
        array2D=[self.data lastObject];
        
        
        if (array2D==nil || array2D.count==3) {
            
            array2D=[NSMutableArray arrayWithCapacity:3];
            
            [self.data addObject:array2D];
        }
        
        NSDictionary * userDic=[users objectAtIndex:i];
        
        UserModel * userModel=[[UserModel alloc]initWithDataDic:userDic];
        
        [array2D addObject:userModel];
    }

    _tableView.data=self.data;
    
    [_tableView reloadData];
    
    //返回数据不精确
    if (users.count<[FRIENDSIZE intValue]-2) {
        
        self.tableView.islast=YES;
        
    }else{
        
        self.tableView.islast=NO;
        
    }
    
    //下拉弹回去
    if (self.next_cursor==nil)  [_tableView doneLoadingTableViewData];

     _next_cursor = [[result objectForKey:@"next_cursor"] stringValue];
    
   
    
}

#pragma mark UITableViewEventDelegate
//下拉刷新
-(void)pullDown:(BaseTableView *)tableView
{

    self.next_cursor=nil;
    
    _data=[NSMutableArray array];
    
    [self loadfriend];
    

}
//加载更多
-(void)pullUp:(BaseTableView *)tableView
{

    [self loadfriend];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
