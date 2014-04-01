//
//  UserinfoView.h
//  weibo
//
//  Created by laijiawei on 14-3-31.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "RectButton.h"
@interface UserinfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property(nonatomic,retain)UserModel * userModel;
@property (weak, nonatomic) IBOutlet RectButton *attButton;
@property (weak, nonatomic) IBOutlet RectButton *fansButton;

@end
