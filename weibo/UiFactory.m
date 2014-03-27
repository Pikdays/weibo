//
//  UiFactory.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "UiFactory.h"

@implementation UiFactory

+(ThemeButton *)createButton:(NSString *)imageName highImage:(NSString *)highlightedImage
{

    ThemeButton * button=[[ThemeButton alloc]initWithImage:imageName highImage:highlightedImage];
    
    return button;

}

+(ThemeButton *)createbackButton:(NSString *)BackImageName BackhighImage:(NSString *)BackhighlightedImage
{

    ThemeButton * button=[[ThemeButton alloc]initWithBackImage:BackImageName BackhighImage:BackhighlightedImage];
    return button;

}

+(ThemeImageView *)createImageView:(NSString *)imageName{

    return [[ThemeImageView alloc]initWithImageName:imageName];

}@end
