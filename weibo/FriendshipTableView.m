//
//  FriendshipTableView.m
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "FriendshipTableView.h"
#import "FriendshipTableCell.h"

@implementation FriendshipTableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid=@"celleid";
    

    FriendshipTableCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    if (cell==nil) {
        
        cell=[[FriendshipTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] ;
        
      cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }
    
    cell.data=[self.data objectAtIndex:indexPath.row];
    
        
    
    return cell;
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 105;
}



@end
