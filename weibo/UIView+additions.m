//
//  UIView+additions.m
//  weibo
//
//  Created by laijiawei on 14-3-30.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "UIView+additions.h"

@implementation UIView (additions)
-(UIViewController *)viewController
{

    UIResponder * next= [self nextResponder];
    
    while (next!=nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }else{
            next=[next nextResponder];
        }
    }
    return nil;
}
@end
