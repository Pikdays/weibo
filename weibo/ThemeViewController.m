//
//  ThemeViewController.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"
@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"选择主题";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _themesPlist=[ThemeManager shareInstance].themesPlist;
    
    _themeKeys=[_themesPlist allKeys];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _themesPlist.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid=@"celleid";
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil)
        
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    
    
    cell.textLabel.text=[_themeKeys objectAtIndex:indexPath.row];
    
    //选中打钩
    
    if ([[ThemeManager shareInstance].themeName isEqualToString:[_themeKeys objectAtIndex:indexPath.row]]) {
 
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        currenindex=indexPath.row;
    }

    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单选
    if (indexPath.row != currenindex) {
        
          [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currenindex inSection:0]].accessoryType=UITableViewCellAccessoryNone;
        
        [tableView cellForRowAtIndexPath:indexPath].accessoryType=UITableViewCellAccessoryCheckmark;
        
        currenindex=indexPath.row;
    }
    
    
    NSString * themeName=[_themeKeys objectAtIndex:indexPath.row];
    
    if ([themeName isEqualToString:@"default"]) {
        themeName=nil;
    }
    //同步到本地

    [[NSUserDefaults standardUserDefaults]setObject:themeName forKey:kThemeName];
    
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [ThemeManager shareInstance].themeName=themeName;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:KThemeDidChangeNotification object:themeName];
    
  //  [tableView reloadData];
    
}

@end
