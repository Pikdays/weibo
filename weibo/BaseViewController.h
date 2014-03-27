//
//  BaseViewController.h
//  weibo
//
//  Created by laijiawei on 14-3-16.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SinaWeibo.h"

#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController

@property(nonatomic,assign)BOOL isBackButton;

@property(nonatomic,retain)UIView * loadingView;

@property(nonatomic,retain)MBProgressHUD *hud;



- (SinaWeibo *)sinaweibo;

-(void)showloading:(BOOL)show;


-(void)showhud;

-(void)hidehud;

-(void)showhud_custom:(NSString *)title;




@end

