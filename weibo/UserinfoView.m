//
//  UserinfoView.m
//  weibo
//
//  Created by laijiawei on 14-3-31.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "UserinfoView.h"
#import "UIImageView+WebCache.h"
@implementation UserinfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * view=[[[NSBundle mainBundle]loadNibNamed:@"UserinfoView" owner:self options:nil]lastObject];
        
        self.size=view.size;
    
       
        [self addSubview:view];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString * imagePath=_userModel.avatar_large;
    
    
    if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
        
        
        _userImageView.image=[UIImage imageNamed:imagePath];
        
        
        [_userImageView setImageWithURL:[NSURL URLWithString:imagePath]];
        
    }
    
    _nickName.text=_userModel.screen_name;
    
    _address.text=_userModel.location;
    
    _desc.text=_userModel.description;
    
    
    
    
    _countLabel.text=[NSString stringWithFormat:@"共有%@条微博",_userModel.statuses_count];
    
    _attButton.toptitle=[_userModel.friends_count stringValue];
    
    _attButton.downtitle=@"关注";

    
    
    long f=[_userModel.followers_count longValue];
    
    
    
    NSString *fans=[NSString stringWithFormat:@"%@",_userModel.followers_count];
    
    
    if (f>=10000)  fans=[NSString stringWithFormat:@"%ld万",f/10000];
    

    
    _fansButton.toptitle=fans;

    _fansButton.downtitle=@"粉丝";
    
    [_fansButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    

}
-(void)click
{

    NSLog(@"click");

}



@end
