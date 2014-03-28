//
//  CommontCell.m
//  weibo
//
//  Created by laijiawei on 14-3-28.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"

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

    _contentLabel=[[RTLabel alloc]initWithFrame:CGRectMake(_userImageView.right+10, _nickName.bottom+10, 240, 10)];
    _contentLabel.font=[UIFont systemFontOfSize:14.0f];
    _contentLabel.delegate=self;
    _contentLabel.linkAttributes=[NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    _contentLabel.selectedLinkAttributes=[NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    
    [self.contentView addSubview:_contentLabel];

}

-(void)layoutSubviews
{

    //头像
    NSString * imagePath=_commentModel.user.profile_image_url;
    
    if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
        
        
        [_userImageView setImageWithURL:[NSURL URLWithString:imagePath]];
    }
    
    //昵称
    _nickName.text=_commentModel.user.screen_name;
    
    
    if (_commentModel.created_at!=nil) {
        
        _timeLabel.hidden=NO;
        
        //发布日期        
        _timeLabel.text=[UIUtils fomateString:_commentModel.created_at];
        
        
    }else{
        _timeLabel.hidden=YES;
    }

    //内容
    
    NSString * text=_commentModel.text;
    
    
    NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    
    
    NSArray *array = [text componentsMatchedByRegex:regex];
    
    for (NSString *link in array) {
        
        NSString * replaceing=nil;
        
        if ([link hasPrefix:@"@"]) {
            replaceing=[NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[link URLEncodedString],link];
        }else if ([link hasPrefix:@"http"]){
            replaceing=[NSString stringWithFormat:@"<a href='%@'>%@</a>",link,link];
            
        }else if([link hasPrefix:@"#"]){
            replaceing=[NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[link URLEncodedString],link];
            
        }
        
        if (replaceing!=nil) {
            text = [text stringByReplacingOccurrencesOfString:link withString:replaceing];
            
        }
        
    }
   
    _contentLabel.text=text;
    
    _contentLabel.height=_contentLabel.optimumSize.height;
    
    
    
    
}

+ (CGFloat)getCommentcellViewHeight:(CommentModel *)commentModel
{


    RTLabel * rt=[[RTLabel alloc]initWithFrame:CGRectMake(0, 0, 240, 0)];
    
    rt.font=[UIFont systemFontOfSize:14.0f];
    rt.text=commentModel.text;
    
   float height = rt.optimumSize.height;

    return height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
