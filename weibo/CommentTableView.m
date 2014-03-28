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
@end
