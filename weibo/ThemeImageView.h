//
//  ThemeImageView.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property(nonatomic,assign)int leftCapWidth;
@property(nonatomic,assign)int topCapHeight;
@property(nonatomic,copy) NSString * imageName;

-(id)initWithImageName:(NSString *)imageName;

@end
