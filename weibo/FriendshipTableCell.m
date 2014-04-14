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

-(void)layoutSubviews
{

    
    for (int i=0; i<_data.count; i++) {
        
        UserModel * model=[self.data objectAtIndex:i];
        
        int tag=100+i;
        

        
        UserGridView * userGridView=(UserGridView *)[self.contentView viewWithTag:tag];
        
        userGridView.frame= CGRectMake(100*i, 10, 96, 96);
        
        userGridView.model=model;


    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
