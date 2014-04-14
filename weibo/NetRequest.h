//
//  NetRequest.h
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
typedef void (^requestBlock)(id result);
@interface NetRequest : NSObject
+ (ASIFormDataRequest *)requestWithBlock:(NSString *)url
                          httpMethod:(NSString *)httpMethod
                              params:(NSDictionary *)params
                                 completeBlock:(requestBlock)block;

@end
