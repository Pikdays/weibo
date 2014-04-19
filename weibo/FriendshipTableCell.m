//
//  FriendshipTableCell.m
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "FriendshipTableCell.h"
#import "UserGridView.h"
#import "UserModel.h"

@implementation FriendshipTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        
    }
    return self;
}
-(void)initView
{
    
    //不能用_data.count
    for (int i=0; i<3; i++) {
        
        UserGridView * userGridView=[[UserGridView alloc]initWithFrame:CGRectZero];
        
        userGridView.tag=100+i;
        
        
        [self.contentView addSubview:userGridView];
        
    }


}
-(void)setData:(NSArray *)data
{
    _data=data;

    for (int i=0; i<3; i++) {
        
      UserGridView * userGridView=(UserGridView *)[self.contentView viewWithTag:(100+i)];
        
       userGridView.hidden=YES;
        
    }
}
-(void)layoutSubviews
{
    
    for (int i=0; i<self.data.count; i++) {
        
        UserGridView * userGridView=(UserGridView *)[self.contentView viewWithTag:(100+i)];
        
        userGridView.frame= CGRectMake(100*i+11, 10, 95, 95);
        
        
        UserModel * model=[self.data objectAtIndex:i];
        
        userGridView.model=model;
        
        userGridView.hidden=NO;

        
        //解决cell复用的问题，让cell刷新视图
        [userGridView setNeedsLayout];
        
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
