//
//  SendViewController.m
//  weibo
//
//  Created by laijiawei on 14-4-5.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "SendViewController.h"
#import "UiFactory.h"
#import "NearbyViewController.h"
#import "BaseNavigationController.h"
@interface SendViewController ()

@end

@implementation SendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.title=@"发布微博";
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showkeyboard:) name:UIKeyboardWillShowNotification object:nil];
        self.isBackButton=NO;
        self.isCancelButton=YES;
 
    
    }
    return self;
}

- (void)viewDidLoad
{
  
    //显示键盘
    [self.textView becomeFirstResponder];
    [super viewDidLoad];
    

    

    
    _butarray=[NSMutableArray array];
    
  
    
    
    UIButton * completebut=[UiFactory createNavButton:CGRectMake(0, 0, 45, 30) title:@"完成" target:self action:@selector(butclick:)];
    
    completebut.tag=101;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:completebut];
    
    
    NSArray * imageNames=[NSArray arrayWithObjects:@"compose_locatebutton_background.png",
                                                  @"compose_camerabutton_background.png",
                                                  @"compose_trendbutton_background.png",
                                                  @"compose_mentionbutton_background.png",
                                                  @"compose_emoticonbutton_background.png",
                                                  @"compose_keyboardbutton_background.png",
                                                  nil];
    NSArray * heightimageNames=[NSArray arrayWithObjects:@"compose_locatebutton_background_highlighted.png",
                          @"compose_camerabutton_background_highlighted.png",
                          @"compose_trendbutton_background_highlighted.png",
                          @"compose_mentionbutton_background_highlighted.png",
                          @"compose_emoticonbutton_background_highlighted.png",
                          @"compose_keyboardbutton_background_highlighted.png",
                          nil];
    
    for (int i=0; i<imageNames.count; i++) {
        NSString * imageName=[imageNames objectAtIndex:i];
        NSString * heightimageName=[heightimageNames objectAtIndex:i];
        
        
        UIButton * but=   [UiFactory createButton:imageName highImage:heightimageName];
        
        [but setImage:[UIImage imageNamed:heightimageName] forState:UIControlStateHighlighted];
        
        but.tag=(10+i);
        
        [but addTarget:self action:@selector(toolckick:) forControlEvents:UIControlEventTouchUpInside];
        
        but.frame=CGRectMake(20+(64*i), 30, 23, 19);
        
        [_butarray addObject:but];
        
        [_toolView addSubview:but];
        
        
        //图片拉伸
        
        self.placeImage.width=320;
        UIImage *image=  [self.placeImage.image stretchableImageWithLeftCapWidth:30 topCapHeight:0];
        
        self.placeImage.image=image;
        
        self.placeLabel.left=30;
        
        _placeLabel.sizeToFit;
        
        _placeLabel.width=300;

        if (i==5) {
            but.hidden=YES;
            but.frame=CGRectMake(20+(64*4), 30, 23, 19);

        }
        
    }
    

}
//toolView按钮点击
-(void)toolckick:(UIButton*)button{
    
    if(button.tag==10){
    
        NearbyViewController * near=[[NearbyViewController alloc]init];
        
        BaseNavigationController * nav=[[BaseNavigationController alloc]initWithRootViewController:near];

        
        [self presentViewController:nav animated:YES completion:nil];
        
        near.selectblock=^(NSDictionary * result){
        
            
            _latitude=[result objectForKey:@"lat"];
            _longitude=[result objectForKey:@"lon"];
            
            NSString *address=[result objectForKey:@"address"];
            if (address==nil&&address.length==0) {
                address=[result objectForKey:@"title"];
            }
            
            
            
            _placeView.hidden=NO;
            _placeLabel.text=address;

            
            
        
        };
    
    }


}
- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{

    if ([_request.tag intValue]==100) {

        [self disView];
 
    }

}


//toolbar按钮点击
-(void)butclick:(UIButton*)button
{

    if(button.tag==101){
        
        //发布微博

        NSString * weibo_text= self.textView.text;
        
        if (weibo_text.length>0) {
            NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:weibo_text forKey:@"status"];
            
            [self.sinaweibo requestWithTAG:@"statuses/update.json" params:params httpMethod:@"POST" tag:@"100" delegate:self];
            
        }
    
        
        

    }
    
}

#pragma  mark keyboard

-(void)showkeyboard:(NSNotification *)nsnotification
{
   //注意xib  user autolayout 自适应高度
    NSValue * value=[nsnotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect frame= [value CGRectValue];
    
    float height=frame.size.height;
    
    
    self.toolView.bottom=ScreenHeight-height-20-44;


    self.textView.height=self.toolView.top;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
