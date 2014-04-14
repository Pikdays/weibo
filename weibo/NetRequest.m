//
//  NetRequest.m
//  weibo
//
//  Created by laijiawei on 14-4-14.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "NetRequest.h"
#import "JSONKit.h"

#define Base_URl @"https://open.weibo.cn/2/"


@implementation NetRequest

+ (ASIFormDataRequest *)requestWithBlock:(NSString *)url
                              httpMethod:(NSString *)httpMethod
                                  params:(NSDictionary *)params
                                   completeBlock:(requestBlock)block
{
    //https://open.weibo.cn/2/statuses/home_timeline.json?count=10&access_token=2.00VUpgQCWF5kIB4550c7bf3a02IQk5

    
    NSDictionary *sinaweiboInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiboAuthData"];

    NSString   * accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
    
    url= [Base_URl stringByAppendingFormat:@"%@?access_token=%@",url,accessToken];
    
    //GET请求
    if ([httpMethod isEqualToString:@"GET"]) {
    
        if (params!=nil&&params.count>0) {
            

          NSArray * keys=params.allKeys;
            
            NSString * param=nil;
        
            for (int i=0; i<keys.count; i++) {
                
                param=[params objectForKey:keys[i]];
                
                
                url= [url stringByAppendingFormat:@"&%@=%@",keys[i],param];
                
            }
            
        }
        
        
    }
    
    NSURL *requesturl=[[NSURL alloc]initWithString:url];
    
    
   __block ASIFormDataRequest * request=[[ASIFormDataRequest alloc]initWithURL:requesturl];
    
    
    request.timeOutSeconds=60;
    
    request.requestMethod=httpMethod;

    //POST请求
    if ([httpMethod isEqualToString:@"POST"]) {
    
        if (params!=nil&&params.count>0) {
            
            
            NSArray * keys=params.allKeys;
            
            
            for (int i=0; i<keys.count; i++) {
                
                NSString *key=[keys objectAtIndex:i];

                
                 id * param=[params objectForKey:key];
                
    
                if ([param isKindOfClass:[NSData class]]) {
                    
                    [request addData:param forKey:keys[i]];
                    
                }else{
                
                    [request addPostValue:param forKey:keys[i]];
                
                }
                
            }
            
        }

    
    
    }
    
    NSLog(@"url----%@",url);
    
     [request setCompletionBlock:^{
       
         NSData *data=request.responseData;
         
         id result=nil;
         
         float version=WXHLOSVersion();
         
         if (version>=5.0) {
             
             result=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         }else
         {
             //jsonkit
             result=[data objectFromJSONData];
         }
         if (block!=nil) {
             
             block(result);
             
         }
         
     }];
    
    [request startAsynchronous];
    
    return request;
}

@end


