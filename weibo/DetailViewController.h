//
//  DetailViewController.h
//  weibo
//微博正文
//  Created by laijiawei on 14-3-27.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "CommentTableView.h"

@interface DetailViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewEventDelegate>

@property (weak, nonatomic) IBOutlet CommentTableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UIView *headBarView;

@property(nonatomic,retain)WeiboModel * weiboModel;

@property(nonatomic,copy)NSString * topId;     //最大的id

@property(nonatomic,copy)NSString * downId;     //最小的id


@property(nonatomic,retain)NSMutableArray * comments;  //保存所有的数据

@property(nonatomic,assign)BOOL isrefresh;          //判断是否是下拉刷新操作

@property(nonatomic,assign)BOOL ismore;          //判断是否加载更多

@end
