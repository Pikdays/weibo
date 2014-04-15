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

@interface FriendshipViewController ()

@end

@implementation FriendshipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"关注列表";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     _data=[NSMutableArray array];
    
    
    if (_uid!=nil&&_uid.length>0){
        
        NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:_uid forKey:@"uid"];
        
     //   NSMutableDictionary * params=[NSMutableDictionary dictionaryWithObject:@"记忆的天空699" forKey:@"screen_name"];

        
       [params setObject:@"11" forKey:@"count"];
        
        [NetRequest requestWithBlock:@"friendships/friends.json" httpMethod:@"GET" params:params completeBlock:^(id result) {
            
            [self loaddatafinish:result];
            
        }];
        
        
    }

}


-(void)loaddatafinish:(id)result
{

    
   NSArray *users = [result objectForKey:@"users"];
    
    NSMutableArray *array2D=nil;
    
    for (int i=0; i<users.count; i++) {
        
        if (i%3==0) {
            
            array2D=[NSMutableArray arrayWithCapacity:3];
            
            [self.data addObject:array2D];
        }
        
        
        NSDictionary * userDic=[users objectAtIndex:i];
        
        UserModel * userModel=[[UserModel alloc]initWithDataDic:userDic];
        

        [array2D addObject:userModel];
        
        

    }


    _tableView.data=self.data;
    
    [_tableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
