//
//  WeiboView.m
//  weibo
//
//  Created by laijiawei on 14-3-19.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "WeiboView.h"
#import "UiFactory.h"
#import "UIImageView+WebCache.h"
#import "ThemeImageView.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
#define LIST_FONT   14.0f           //列表中文本字体
#define LIST_REPOST_FONT  13.0f;    //列表中转发的文本字体
#define DETAIL_FONT  18.0f          //详情的文本字体
#define DETAIL_REPOST_FONT 17.0f    //详情中转发的文本字体
@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self init_view];
        
       // _parseText=[NSMutableString string];
        
        //注意要持有
        
        _parseText=[[NSMutableString alloc]init];

    }
    return self;
}

//初始化视图
-(void)init_view
{

    _text=[[RTLabel alloc]initWithFrame:CGRectZero];
    _text.font=[UIFont systemFontOfSize:14.0f];
    _text.delegate=self;
    _text.linkAttributes=[NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    _text.selectedLinkAttributes=[NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];


    [self addSubview:_text];
    
    _image=[[UIImageView alloc]initWithFrame:CGRectZero];
    _image.image=[UIImage imageNamed:@"page_image_loading.png"];
    
    [self addSubview:_image];
    

    
    //转发微博视图的背景
    _repostBackView = [UiFactory createImageView:@"timeline_retweet_background.png"];
    UIImage *image = [_repostBackView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _repostBackView.image = image;
    _repostBackView.leftCapWidth = 25;
    _repostBackView.topCapHeight = 10;
    _repostBackView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_repostBackView atIndex:0];

    
}

-(void)parseLink
{
    //cell复用的话就清空原来的数据
    [_parseText setString:@""];
    
    if (_isRePost) {
        NSString * nickname=_weiboModel.user.screen_name;
        
        nickname=[NSString stringWithFormat:@"<a href='user://%@'>%@</a>:",[nickname URLEncodedString],nickname];

        [_parseText appendString:nickname];
    }
    
    NSString * text=_weiboModel.text;

    
    NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    
    
    NSArray *array = [text componentsMatchedByRegex:regex];
    
    for (NSString *link in array) {
        
        //link= [link URLEncodedString];
        
        NSString * replaceing=nil;
        
        if ([link hasPrefix:@"@"]) {
            replaceing=[NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[link URLEncodedString],link];
        }else if ([link hasPrefix:@"http"]){
            replaceing=[NSString stringWithFormat:@"<a href='%@'>%@</a>",link,link];

        }else if([link hasPrefix:@"#"]){
            replaceing=[NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[link URLEncodedString],link];
        
        }
        
        if (replaceing!=nil) {
            text = [text stringByReplacingOccurrencesOfString:link withString:replaceing];

        }
        
    }

    [_parseText appendString:text];

}
//加载视图数据，展现视图，子视图布局,会被调用多次
-(void)layoutSubviews
{

    [super layoutSubviews];//重写父类的方法，记得先调用父类的方法
    
    _text.frame=CGRectMake(0, 0, self.width, self.height);
    if (_isRePost) {
        _text.frame=CGRectMake(10, 10, self.width-20, 0);
    }
    
    
    _text.text=_parseText;
    

    
    //获取字体大小
    float fontSize = [WeiboView getFontSize:self.isDetail isRepost:self.isRePost];
    
    _text.font = [UIFont systemFontOfSize:fontSize];
    
    _text.height=_text.optimumSize.height;

    
    WeiboModel * rePostModel=_weiboModel.relWeibo;
    
    //转发视图
    if (rePostModel !=nil) {
        _repostView.weiboModel=rePostModel;
        
        //计算转发微博视图的高度
        float height = [WeiboView getWeiboViewHeight:rePostModel isRepost:YES isDetail:self.isDetail];
        
        _repostView.frame = CGRectMake(0, _text.bottom, self.width, height);

        _repostView.hidden=NO;
    }else{
        _repostView.hidden=YES;
    
    }
    //微博图片
    
    if(self.isDetail){
        
        NSString * imagePath=_weiboModel.bmiddleImage;
        
        
        NSLog(@"imagePath--%@",imagePath);

        
        if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
            
            
            _image.image=[UIImage imageNamed:imagePath];
            
            _image.hidden=NO;
            
            _image.frame=CGRectMake(10, _text.bottom+20, 280, 200);
            
            [_image setImageWithURL:[NSURL URLWithString:imagePath]];
            
        }else{
            
            _image.hidden=YES;
        }
    
    
    }else{
        
        NSString * imagePath=_weiboModel.thumbnailImage;
        
        if (imagePath !=nil && ![@"" isEqualToString:imagePath]) {
            _image.image=[UIImage imageNamed:imagePath];
            
            _image.hidden=NO;
            
            _image.frame=CGRectMake(10, _text.bottom+20, 70, 80);
            
            [_image setImageWithURL:[NSURL URLWithString:imagePath]];
            
        }else{
            
            _image.hidden=YES;
        }
    
    
    
    }
    

    

    //----------------转发的微博视图背景_repostBackView---------------
    if (self.isRePost) {
        _repostBackView.frame = self.bounds;
        _repostBackView.hidden = NO;
    } else {
        _repostBackView.hidden = YES;
    }
    
    
}


#pragma mark RTLabel delegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{

    NSLog(@"url%@",[[url absoluteString]URLDecodedString]);

}

//重写weiboModel的serter方法，因为不能直接创建转发微博视图，会有死循环
-(void)setWeiboModel:(WeiboModel *)weiboModel

{
    _weiboModel=weiboModel;

    if (_repostView  == nil) {
        _repostView=[[WeiboView alloc]initWithFrame:CGRectZero];
        _repostView.isRePost=YES;
        [self addSubview:_repostView];
    }

    //转换超链接
    [self parseLink];

}
#pragma mark - 计算
//获取字体大小
+ (float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost {
    float fontSize = 14.0f;
    
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    }
    else if(!isDetail && isRepost) {
        return LIST_REPOST_FONT;
    }
    else if(isDetail && !isRepost) {
        return DETAIL_FONT;
    }
    else if(isDetail && isRepost) {
        return DETAIL_REPOST_FONT;
    }
    
    return fontSize;
}

//计数微博视图的高度
+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel
                     isRepost:(BOOL)isRepost
                     isDetail:(BOOL)isDetail {
    /**
     *   实现思路：计算每个子视图的高度，然后相加。
     **/
    float height = 0;
    
    //--------------------计算微博内容text的高度------------------------
    RTLabel *textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    float fontsize = [WeiboView getFontSize:isDetail isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontsize];
    //判断此微博是否显示在详情页面
    if (isDetail) {
        textLabel.width = kWeibo_Width_Detail;
    } else {
        textLabel.width = kWeibo_Width_List;
    }
    
    
    if (isRepost) {
        textLabel.width-=20;
    }
    textLabel.text = weiboModel.text;
    
    
    height += textLabel.optimumSize.height;
    
    
    //NSLog(@"textLabel--height%f",textLabel.optimumSize.height);
    
    //--------------------计算微博图片的高度------------------------
    
    if(isDetail){
    
        NSString *bmiddleImage = weiboModel.bmiddleImage;
        if (bmiddleImage != nil && ![@"" isEqualToString:bmiddleImage]) {
            height += (200+10+20);
        }
    
    }else{
    
        NSString *thumbnailImage = weiboModel.thumbnailImage;
        if (thumbnailImage != nil && ![@"" isEqualToString:thumbnailImage]) {
            height += (80+10+20);
        }
    
    }
    
   
    
    //--------------------计算转发微博视图的高度------------------------
    //转发的微博
    WeiboModel *relWeibo = weiboModel.relWeibo;
    if (relWeibo != nil) {
        //转发微博视图的高度
        float repostHeight = [WeiboView getWeiboViewHeight:relWeibo isRepost:YES isDetail:isDetail];
        height += (repostHeight);
    }
    
    if (isRepost == YES) {
        height += 30;
    }
    
    return height;
}

@end
