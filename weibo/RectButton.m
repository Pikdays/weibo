//
//  RectButton.m
//  weibo
//
//  Created by laijiawei on 14-3-31.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "RectButton.h"

@implementation RectButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.text=@"hello \n hhh";
    }
    return self;
}

-(void)awakeFromNib
{
    [self setBackgroundImage:[UIImage imageNamed:@"userinfo_apps_background.png"] forState:UIControlStateNormal];
    
}

-(void)setToptitle:(NSString *)toptitle
{

    UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(0,10, 70, self.height/2)];
    
    label.text=toptitle;
    
    label.backgroundColor=[UIColor clearColor];
    
    label.textColor=[UIColor blueColor];
    
    label.textAlignment=NSTextAlignmentCenter;

    
    [self addSubview:label];
    

}

-(void)setDowntitle:(NSString *)downtitle
{

    UILabel *downlabel= [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/2, 70, self.height/2)];
    
    downlabel.text=downtitle;
    
    
    downlabel.font=[UIFont systemFontOfSize:13.0f];
    
    downlabel.backgroundColor=[UIColor clearColor];
    
    downlabel.textAlignment=NSTextAlignmentCenter;
    
    [self addSubview:downlabel];

}



@end
