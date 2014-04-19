//
//  WeiboCell.m
//  weibo
//
//  Created by laijiawei on 14-3-19.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "WeiboCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WeiboView.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "RegexKitLite.h"
#import "UserViewController.h"
@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
-(void)gotoUserinfo
{
    UserViewController * view=[[UserViewController alloc]init];
    view.userId=_weiboModel.user.idstr;

    [self.viewController.navigationController pushViewController:view animated:YES];
    
}


-(void)initView
{

    _userImage =[[UIImageView alloc]initWithFrame:CGRectZero];
    _userImage.backgroundColor=[UIColor clearColor];
    //设置图片圆角
    _userImage.layer.cornerRadius=5;
    _userImage.layer.borderWidth=.5;
    _userImage.layer.borderColor=[UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds=YES;
    
    //最重要的，设置为YES才能点击，uiview默认是NO
    _userImage.userInteractionEnabled = YES;

    
    //点击头像
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoUserinfo)];
    
    [_userImage addGestureRecognizer:singleTap];
    

    
    [self.contentView addSubview:_userImage];
    
    //昵称
    _nickLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _nickLabel.font=[UIFont systemFontOfSize:14.0];
    _nickLabel.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:_nickLabel];
    //转发数
    _repostCount=[[UILabel alloc]initWithFrame:CGRectZero];
    _repostCount.font=[UIFont systemFontOfSize:12.0];
    _repostCount.backgroundColor=[UIColor clearColor];
    _repostCount.textColor= [UIColor blackColor];
    [self.contentView addSubview:_repostCount];
    
    //评论数
    _commentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _commentLabel.font=[UIFont systemFontOfSize:12.0];
    _commentLabel.backgroundColor=[UIColor clearColor];
    _commentLabel.textColor= [UIColor blackColor];
    [self.contentView addSubview:_commentLabel];
    
    //发布来源
    _sourceLabel=[[RTLabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.font=[UIFont systemFontOfSize:12.0];
    _sourceLabel.backgroundColor=[UIColor clearColor];
    _sourceLabel.textColor= [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    
    //发布时间
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _timeLabel.font=[UIFont systemFontOfSize:12.0];
    _timeLabel.backgroundColor=[UIColor clearColor];
    _timeLabel.textColor= [UIColor blueColor]  ;
    [self.contentView addSubview:_timeLabel];
    
    _weiboView=[[WeiboView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
    
    self.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"statusdetail_cell_sepatator.png"]];
    
    
    
}

-(NSString *) parseSource:(NSString *)source
{
    
    NSString *regex = @">\\w+<";
    
    
    NSArray *array = [source componentsMatchedByRegex:regex];
    
    NSString * s=nil;
   
    if (array!=nil&&array.count>0) {
        
        NSString * res=array[0];
        
        NSRange range;
        range.location=1;
        range.length=res.length-2;
        
       s=[res substringWithRange:range];
    
    }

    
    return s;

}

-(void)layoutSubviews
{

    [super layoutSubviews];
    
    //用户头像
    _userImage.frame=CGRectMake(5, 5, 35, 35);
    
    
    NSString * imagePath=_weiboModel.user.profile_image_url;
    
    if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
    
        
        [_userImage setImageWithURL:[NSURL URLWithString:imagePath]];
    }
    
    //昵称
    
    _nickLabel.frame=CGRectMake(50, 5, 200, 20);
    _nickLabel.text=_weiboModel.user.screen_name;
    
    if (_weiboModel.createDate!=nil) {
        
        _timeLabel.hidden=NO;

        //发布日期
        NSString *createDate=[UIUtils dateFromFomate:_weiboModel.createDate formate:@"E M d HH:mm:ss Z yyyy"];
        
        
        NSString *date=[UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
        
        
        _timeLabel.text=date;
        
        _timeLabel.frame=CGRectMake(50, self.height-20, 100, 20);
        [_timeLabel sizeToFit];
        
    }else{
        _timeLabel.hidden=YES;
    }
    //来源
    if (_weiboModel.source!=nil) {
        _sourceLabel.hidden=NO;
        _sourceLabel.text=[NSString stringWithFormat:@"来自%@",[self parseSource:_weiboModel.source]];
        _sourceLabel.frame=CGRectMake(_timeLabel.right+8, _timeLabel.top, 100, 20);
        [_sourceLabel sizeToFit];

    }else{
        _sourceLabel.hidden=YES;
    }
    
    //转发数
    if (_weiboModel.repostsCount!=nil) {
        _repostCount.hidden=NO;
        _repostCount.text=[NSString stringWithFormat:@"转发%@",_weiboModel.repostsCount];
        _repostCount.frame=CGRectMake(220,_nickLabel.top, 100, _nickLabel.height);
        [_repostCount sizeToFit];
        
    }else{
        _repostCount.hidden=YES;
    }

    //评论数
    if (_weiboModel.commentsCount!=nil) {
        _commentLabel.hidden=NO;
        _commentLabel.text=[NSString stringWithFormat:@"评论%@",_weiboModel.commentsCount];
        
        _commentLabel.frame=CGRectMake(_repostCount.right+8,_repostCount.top, 100, _repostCount.height);
        [_commentLabel sizeToFit];
        
    }else{
        _commentLabel.hidden=YES;
    }
    
    //微博视图_weiboView
    _weiboView.weiboModel = _weiboModel;
    //获取微博视图的高度
    float h = [WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _nickLabel.bottom+10, kWeibo_Width_List, h);
    
    //让_weiboView重新布局，5.1版本错乱
    
    [_weiboView setNeedsLayout];
    
    
    
}
@end
