//
//  faceView.h
//  weibo
//
//  Created by laijiawei on 14-4-8.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectBlock)(NSString * name);


@interface faceView : UIView
{
@private
    NSMutableArray * items;
    
}

@property(nonatomic,retain)UIImageView * enlargeView;//放大镜

@property(nonatomic,copy)NSString * selectImageName;

@property(nonatomic,assign)NSInteger * pagecount;

@property(nonatomic,copy)NSString * selecttitle;

@property(nonatomic,copy)selectBlock block;

@end
