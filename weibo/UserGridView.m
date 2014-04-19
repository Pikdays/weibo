//
//  UserGridView.m
//  weibo
//
//  Created by laijiawei on 4-4-4.
//  Copyright (c) 204年 laijiawei. All rights reserved.
//

#import "UserGridView.h"
#import "UIImageView+WebCache.h"
#import "UserViewController.h"
@implementation UserGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //背景
        self.frame=CGRectMake(0, 0, 95, 95);
        
       
        _UserImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 9, 55, 55)];
        
        
        [self addSubview:_UserImage];
        
        
        _nickName=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 55, 17)];
        
        _nickName.font=[UIFont systemFontOfSize:12.0f];
        
        _nickName.textAlignment=NSTextAlignmentCenter;

        _nickName.backgroundColor=[UIColor clearColor];


        
         [self addSubview:_nickName];
        
        
        _fansNum=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 55, 10)];
        
        _fansNum.textColor=[UIColor blueColor];
        
        _fansNum.textAlignment=NSTextAlignmentCenter;
        
        _fansNum.font=[UIFont systemFontOfSize:12.0f];
        
        _fansNum.backgroundColor=[UIColor clearColor];

        
        [self addSubview:_fansNum];
        
        
        UIImageView * backView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profile_button3_1.png"]];
        
        backView.frame=self.frame;
        
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
    
    
    self.nickName.text=_model.screen_name;
    
    long f=[_model.followers_count longValue];

    
    NSString *fans=[NSString stringWithFormat:@"%@",_model.followers_count];
    
    if (f>=10000)  fans=[NSString stringWithFormat:@"%ld万",f/10000];
    
    
    self.fansNum.text=fans;
    

}

-(void)gotoUserinfo
{
    UserViewController * view=[[UserViewController alloc]init];
        
    view.userId=_model.idstr;
    
    [self.viewController.navigationController pushViewController:view animated:YES];
    
}
@end
