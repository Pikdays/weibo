//
//  ThemeManager.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KThemeDidChangeNotification @"kThemeDidChangeNofication"


@interface ThemeManager : NSObject

//当前使用的主题名称
@property(nonatomic,copy)NSString * themeName;

@property(nonatomic,retain)NSDictionary *themesPlist;
+(ThemeManager *)shareInstance;

-(UIImage *)getThemeImage:(NSString * )imageName;



@end
