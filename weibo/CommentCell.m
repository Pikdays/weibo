//
//  CommontCell.m
//  weibo
//
//  Created by laijiawei on 14-3-28.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib
{

    _contentLabel=[[RTLabel alloc]initWithFrame:CGRectMake(_userImageView.left+10, _nickName.bottom+5, 240, 10)];
    _contentLabel.font=[UIFont systemFontOfSize:14.0f];
    _contentLabel.delegate=self;
    _contentLabel.linkAttributes=[NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    _contentLabel.selectedLinkAttributes=[NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    
    [self.contentView addSubview:_contentLabel];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
