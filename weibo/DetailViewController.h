//
//  DetailViewController.h
//  weibo
//
//  Created by laijiawei on 14-3-27.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
