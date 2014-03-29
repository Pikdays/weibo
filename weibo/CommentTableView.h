//
//  CommontTableView.h
//  weibo
//
//  Created by laijiawei on 14-3-28.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseTableView.h"

@interface CommentTableView : BaseTableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSDictionary * commentsdic;


@end
