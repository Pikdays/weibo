//
//  CommontCell.h
//  weibo
//
//  Created by laijiawei on 14-3-28.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface CommontCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(retain,nonatomic)RTLabel * _contentLabel;


@end