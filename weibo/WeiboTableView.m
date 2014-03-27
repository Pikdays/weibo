//
//  WeiboTableView.m
//  weibo
//
//  Created by laijiawei on 14-3-23.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "WeiboView.h"

@implementation WeiboTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {

      
    
    }
    return self;
}



#pragma mark UITableViewDataSource



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid=@"celleid";
    
    WeiboCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    if (cell==nil) {
        
        cell=[[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] ;
        
        
    }
    
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    
    cell.weiboModel=weibo;
    
    
    return cell;
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    float height = [WeiboView getWeiboViewHeight:weibo isRepost:NO isDetail:NO];
    
    height += 60;
    
    return height;
}


@end
