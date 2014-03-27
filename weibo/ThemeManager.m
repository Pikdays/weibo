//
//  ThemeManager.m
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "ThemeManager.h"

static ThemeManager *sigleton=nil;

@implementation ThemeManager

+(ThemeManager *)shareInstance
{
    
    if (sigleton ==nil) {
        @synchronized(self){
            sigleton=[[ThemeManager alloc]init];
        }
    }

    return sigleton;

}

-(UIImage *)getThemeImage:(NSString * )imageName
{

    
    if (imageName.length==0) {
      
        return nil;
    }
    
    NSString * path=[[self getThemePath] stringByAppendingPathComponent:imageName];
    
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    return image;
                

}

-(NSString *)getThemePath
{
    //程序包路径
    NSString * mainPath=[[NSBundle mainBundle]resourcePath];

    if (self.themeName==nil) {
        
        return  mainPath;
    }
    
    //主题路径
    NSString * themepath=[self.themesPlist objectForKey:self.themeName];
    
    
    //返回全路径
    return  [mainPath stringByAppendingPathComponent:themepath];

}

-(id)init
{
    self=[super init];

    if (self) {
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        
       self.themesPlist=[NSDictionary dictionaryWithContentsOfFile:dataPath];
        //初始化主题默认为空
        self.themeName=nil;
    }
  
    
    
    return self;


}


//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}


@end
