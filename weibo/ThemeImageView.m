//
//  ThemeImageView.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView


-(id)initWithImageName:(NSString *)imageName
{
    self=[self init];
    if (self) {
        //self就是调用set
        self.imageName=imageName;
    }
    return self;
}

-(void)loadimage
{

    UIImage * image=[[ThemeManager shareInstance]getThemeImage:_imageName];
    
    image=[image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapHeight];
        
    [self setImage:image];    

}
-(id)init
{
    
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:KThemeDidChangeNotification object:nil];
    }
    return self;
    
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



//通知

-(void)themeNotification:(NSNotification *) notification
{
    
    [self loadimage];
    
    
}

//清除通知不然有可能崩溃
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
@end
