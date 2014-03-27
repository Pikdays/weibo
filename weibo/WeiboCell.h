//
//  WeiboCell.h
//  weibo
//微博列表的cell
//  Created by laijiawei on 14-3-19.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboModel;
@class WeiboView;

@interface WeiboCell : UITableViewCell
{

    UIImageView *_userImage;   //用户头像
    UILabel *_nickLabel;        //用户昵称
    UILabel *_repostCount;     //转发数
    UILabel *_commentLabel;    //评论数
    UILabel *_sourceLabel;     //来源
    UILabel *_timeLabel;       //发布时间
    
}

@property(nonatomic,retain)WeiboModel * weiboModel;

//微博视图
@property(nonatomic,retain)WeiboView * weiboView;
@end
