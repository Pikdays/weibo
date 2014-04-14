//
//  UserGridView.m
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "UserGridView.h"
#import "UIImageView+WebCache.h"
#import "UserViewController.h"
@implementation UserGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * view=[[[NSBundle mainBundle]loadNibNamed:@"UserGridView" owner:self options:nil]lastObject];
        
        self.size=view.size;
        
        [self addSubview:view];
        //背景
        
        UIImageView * backView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profile_button3_1.png"]];
        
        [self insertSubview:backView atIndex:0];

    }
    return self;
}

//展示数据
-(void)layoutSubviews
{
    
    
    //先调用父类的方法
    [super layoutSubviews];
    
    NSString * imagePath=_model.avatar_large;
    
    if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
        
        _UserImage.image=[UIImage imageNamed:imagePath];
        
        [_UserImage setImageWithURL:[NSURL URLWithString:imagePath]];
        
    }

    //最重要的，设置为YES才能点击，uiview默认是NO
    _UserImage.userInteractionEnabled = YES;
    
    
    //点击头像
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoUserinfo)];
    
    [_UserImage addGestureRecognizer:singleTap];
    
    
    _nickName.text=_model.screen_name;
    
    long f=[_model.followers_count longValue];

    
    NSString *fans=[NSString stringWithFormat:@"%@",_model.followers_count];
    
    if (f>=10000)  fans=[NSString stringWithFormat:@"%ld万",f/10000];
    
    _fansNum.text=fans;
}

-(void)gotoUserinfo
{
    UserViewController * view=[[UserViewController alloc]init];
    view.userName=_model.screen_name;
    [self.viewController.navigationController pushViewController:view animated:YES];
    
}
@end
