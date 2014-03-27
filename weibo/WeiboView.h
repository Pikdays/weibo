//
//  WeiboView.h
//  weibo
//微博视图
//  Created by laijiawei on 14-3-19.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
#import "WeiboModel.h"
#import "ThemeImageView.h"


#define kWeibo_Width_List  (320-60) //微博在列表中的宽度
#define kWeibo_Width_Detail 300     //微博在详情页面的宽度


@interface WeiboView : UIView<RTLabelDelegate>
{
    RTLabel *_text;       //微博标题

    UIImageView * _image;   //微博图片
    
    ThemeImageView * _repostBackView; //微博转发背景图片
    
    WeiboView * _repostView;        //转发的微博视图
    
    NSMutableString * _parseText ;   //转换成链接的文本
}

@property(nonatomic,retain)WeiboModel * weiboModel;


@property(nonatomic,assign) BOOL isRePost; //是否转发的微博



//微博视图是否显示在详情页面
@property(nonatomic,assign)BOOL isDetail;

//获取字体大小
+ (float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;

//计数微博视图的高度
+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel
                     isRepost:(BOOL)isRepost
                     isDetail:(BOOL)isDetail;
@end
