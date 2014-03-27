//
//  ThemeButton.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"


@implementation ThemeButton


-(id)initWithImage:(NSString *)imageName highImage:(NSString *)highlightedImage
{
    self=[self init];
    if (self) {
        self.imageName=imageName;
        self.heightimageName=highlightedImage;
        
    }
    
    return self;

}


-(id)initWithBackImage:(NSString *)BackImageName BackhighImage:(NSString *)BackhighlightedImage
{
  
    self=[self init];
    if (self) {
        self.backimageName=BackImageName;
        self.backheightimageName=BackhighlightedImage;
    }
    return self;
}

-(void)loadimage
{

    ThemeManager * manage=[ThemeManager shareInstance];
    
    UIImage * image=[manage getThemeImage:_imageName];
    
    UIImage * heightImage=[manage getThemeImage:_heightimageName];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:heightImage forState:UIControlStateHighlighted];


    UIImage * backimage=[manage getThemeImage:_backimageName];
    
    UIImage * backheightImage=[manage getThemeImage:_backheightimageName];
    
    
    [self setBackgroundImage:backimage forState:UIControlStateNormal];
    [self setBackgroundImage:backheightImage forState:UIControlStateHighlighted];

}

-(id)init
{

    self=[super init];
    if (self) {
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:KThemeDidChangeNotification object:nil];
    }
    return self;

}

//通知

-(void)themeNotification:(NSNotification *) notification
{

    [self loadimage];
    

}

#pragma mark setter
-(void)setImageName:(NSString *)imageName
{

    if (_imageName!=imageName) {
        [_imageName release];
        _imageName=[imageName copy];
    }
    
    [self loadimage];
}


-(void)setHeightimageName:(NSString *)heightimageName
{
    
    if (_heightimageName!=heightimageName) {
        [_heightimageName release];
        _heightimageName=[heightimageName copy];
    }
    
    [self loadimage];

}

-(void)setBackimageName:(NSString *)backimageName
{

    if (_backimageName!=backimageName) {
        [_backimageName release];
        _backimageName=[backimageName copy];
    }
    
    [self loadimage];

}

-(void)setBackheightimageName:(NSString *)backheightimageName
{
    if (_backheightimageName!=backheightimageName) {
        [_backheightimageName release];
        _backheightimageName=[backheightimageName copy];
    }
    
    [self loadimage];

}
//清除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
