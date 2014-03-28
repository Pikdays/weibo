//
//  CommontModel.h
//  weibo
//
//  Created by laijiawei on 14-3-28.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseModel.h"
#import "WeiboModel.h"
#import "UserModel.h"

//"created_at": "Tue May 24 18:04:53 +0800 2011",
//"id": 11142488790,
//"text": "我的相机到了。",
//"source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
//"mid": "5610221544300749636",

@interface CommontModel : BaseModel
@property(nonatomic,copy)NSString           *create_at;
@property(nonatomic,copy)NSNumber           *id;
@property(nonatomic,copy)NSString           *text;
@property(nonatomic,copy)NSString           *source;
@property(nonatomic,retain)UserModel        *user;
@property(nonatomic,retain)NSString         *mid;
@property(nonatomic,retain)NSString         *idstr;
@property(nonatomic,retain)WeiboModel         *weibo;
@end
