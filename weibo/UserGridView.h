//
//  UserGridView.h
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserGridView : UIView


@property(nonatomic,retain)UILabel * fansNum;

@property(nonatomic,retain)UILabel * nickName;

@property (retain, nonatomic) UIImageView *UserImage;


@property(nonatomic,retain)UserModel * model;

@end
