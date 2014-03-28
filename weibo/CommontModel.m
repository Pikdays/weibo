//
//  CommontModel.m
//  weibo
//
//  Created by laijiawei on 14-3-28.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "CommontModel.h"

@implementation CommontModel

- (void)setAttributes:(NSDictionary *)dataDic {
    //将字典数据根据映射关系填充到当前对象的属性上。
    [super setAttributes:dataDic];
    
    
    NSDictionary *weibodic = [dataDic objectForKey:@"status"];
    if (weibodic != nil) {
        WeiboModel *weiboModel = [[WeiboModel alloc] initWithDataDic:weibodic];
        self.weibo = weiboModel;
    }
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
        self.user = user;
    }
}

@end
