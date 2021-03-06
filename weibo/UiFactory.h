//
//  UiFactory.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
@interface UiFactory : NSObject



+(ThemeButton *)createButton:(NSString *)imageName highImage:(UIImage *)highlightedImage;

+(ThemeButton *)createbackButton:(NSString *)BackImageName BackhighImage:(UIImage *)BackhighlightedImage;

+(ThemeImageView *)createImageView:(NSString *)imageName;
//创建导航栏按钮

+(UIButton *)createNavButton:(CGRect)frame title:(NSString * )title target:(id)target action:(SEL)action;
@end
