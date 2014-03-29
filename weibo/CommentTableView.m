//
//  CommontTableView.m
//  weibo
//
//  Created by laijiawei on 14-3-28.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"

@implementation CommentTableView

- (id)initWithFrame:(CGRect)frame  style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * cellid=@"celleid";
    
    CommentCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    if (cell==nil) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil]lastObject];
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    WeiboModel *weibo = [self.data objectAtIndex:indexPath.row];
    
    cell.commentModel=weibo;
    
    
    return cell;
    

}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


     return   [CommentCell getCommentcellViewHeight:[self.data objectAtIndex:indexPath.row]]+40;


}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
        
        view.backgroundColor=[UIColor whiteColor];
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10,10, 100, 20)];
        
        label.backgroundColor=[UIColor clearColor];
        
        label.textColor=[UIColor blueColor];
        
        
        label.text=[NSString stringWithFormat:@"评论数:%d",[[_commentsdic objectForKey:@"total_number"] intValue]];
        
        
        label.font=[UIFont systemFontOfSize:16.0f];
        
    
      UIImageView * line=[[UIImageView alloc]initWithFrame:CGRectMake(0,39, tableView.width, 1)];
    
    
      [line setImage:[UIImage imageNamed:@"userinfo_header_separator.png"]];
    
    [view addSubview:label];
    [view addSubview:line];

    
        return view;


}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 40;



}
@end
