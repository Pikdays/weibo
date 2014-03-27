//
//  ThemeViewController.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSInteger  currenindex;
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,retain)NSDictionary * themesPlist;
@property(nonatomic,retain)NSArray *themeKeys;
@end
