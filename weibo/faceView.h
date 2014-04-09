//
//  faceView.h
//  weibo
//
//  Created by laijiawei on 14-4-8.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface faceView : UIView
{
@private
    NSMutableArray * items;
    
}

@property(nonatomic,retain)UIImageView * enlargeView;//放大镜

@property(nonatomic,copy)NSString * selectImageName;


@end
