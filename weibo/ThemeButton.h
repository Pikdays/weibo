//
//  ThemeButton.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

//按钮图片
@property(nonatomic,copy) NSString * imageName;
@property(nonatomic,copy) NSString * heightimageName;

//按钮背景图片
@property(nonatomic,copy) NSString * backimageName;
@property(nonatomic,copy) NSString * backheightimageName;

-(id)initWithImage:(NSString *)imageName highImage:(NSString *)highlightedImage;

-(id)initWithBackImage:(NSString *)BackImageName BackhighImage:(NSString *)BackhighlightedImage;

@end
