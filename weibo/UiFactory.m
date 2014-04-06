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

}


+(UIButton *)createNavButton:(CGRect)frame title:(NSString * )title target:(id)target action:(SEL)action
{

    ThemeButton * but=[self createbackButton:@"navigationbar_button_background.png" BackhighImage:@"navigationbar_button_delete_background.png"];
    but.frame=frame;
    
    [but setTitle:title forState:UIControlStateNormal];
    
    [but addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    but.titleLabel.font=[UIFont systemFontOfSize:13.0];
    
    but.leftCapWidth=3;
    
    return but;

}

@end
