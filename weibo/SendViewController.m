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

#import "NetRequest.h"
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
    
  
    
    
    UIButton * completebut=[UiFactory createNavButton:CGRectMake(0, 0, 45, 30) title:@"发布" target:self action:@selector(butclick:)];
    
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
        
        [but setImage:[UIImage imageNamed:heightimageName] forState:UIControlStateSelected];
        
        but.tag=(10+i);
        
        [but addTarget:self action:@selector(toolckick:) forControlEvents:UIControlEventTouchUpInside];
        
        but.frame=CGRectMake(20+(64*i), 30, 23, 19);
        
        [_butarray addObject:but];
        
        [_toolView addSubview:but];
        
        
        //图片拉伸
        
        
        UIImage *image=  [self.placeImage.image stretchableImageWithLeftCapWidth:30 topCapHeight:0];
        
        self.placeImage.image=image;
        
        self.placeLabel.left=35;
        
        self.placeImage.width=200;
        
        _placeLabel.width=160;

        if (i==5) {
            but.hidden=YES;
            but.frame=CGRectMake(20+(64*4), 30, 23, 19);
            
            [but addTarget:self action:@selector(showkeyboard) forControlEvents:UIControlEventTouchUpInside];

        }
        
    }
    

}
//toolView按钮点击
-(void)toolckick:(UIButton*)button{
//    NSLog(@"%d",button.tag);
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

            UIButton *but=  [_butarray objectAtIndex:0];
            but.selected=YES;
            
        
        };
    
    }
    else if (button.tag==11)
    {
    
        [self selectImage];
    
    }
    
    else if (button.tag==14)
    {
        [self showfaceview];
    }



}

-(void)showfaceview
{

    [_textView resignFirstResponder];
    
    if(_face==nil)
    {
       
        //注意block不要重复调用
        _face=[[faceScrollView alloc]initWithSelectBlock:^(NSString *name) {
           
            
       _textView.text=[_textView.text stringByAppendingString:name];
        
            
        }];
        
            
            
        
        _face.top=ScreenHeight-20-44-_face.height;
        
        _face.transform=CGAffineTransformTranslate(_face.transform, 0, ScreenHeight-20-44);
        
        [self.view addSubview:_face];
    }
    
    UIButton * facebutton=[_butarray objectAtIndex:4];
    UIButton * keyboardbutton=[_butarray objectAtIndex:5];
    
    facebutton.alpha=1;
    keyboardbutton.alpha=0;
    keyboardbutton.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
    
        _face.transform=CGAffineTransformIdentity;
        facebutton.alpha=0;
        
        //调整高度
        self.toolView.bottom=ScreenHeight-_face.height-20-44;
        
        
        self.textView.height=self.toolView.top;
    
    } completion:^(BOOL finished){
    
        [UIView animateWithDuration:0.3 animations:^{
        
            keyboardbutton.alpha=1;
        }];
    
        
    }];
 }

-(void)showkeyboard
{
    [_textView becomeFirstResponder] ;
    UIButton * facebutton=[_butarray objectAtIndex:4];
    UIButton * keyboardbutton=[_butarray objectAtIndex:5];
    
    facebutton.alpha=0;
    keyboardbutton.alpha=1;
    [UIView animateWithDuration:0.3 animations:^{
        
        _face.transform=CGAffineTransformTranslate(_face.transform, 0, ScreenHeight-20-44);
        
        keyboardbutton.alpha=0;
        
    } completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.3 animations:^{
            
                facebutton.alpha=1;

        }];
        
    }];
}

-(void)selectImage
{

    UIActionSheet * as=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    
    [as showInView: self.view];

}
#pragma  mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self showkeyboard];
    return YES;

}


#pragma  mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerControllerSourceType     sourceType;
    


    NSLog(@"%d",buttonIndex);
    //拍照
    if (buttonIndex==0) {
      
        if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备不支持拍照" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        sourceType=UIImagePickerControllerSourceTypeCamera;
        
    }else if (buttonIndex==1)
    {
        //从相册选择
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    
    }else {
        return;
    
    }
    
    
    UIImagePickerController *imagePick=[[UIImagePickerController alloc]init];

    
    imagePick.sourceType=sourceType;
    
    imagePick.delegate=self;

    [self presentViewController:imagePick animated:YES completion:nil];

}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    
    UIImage * seleetImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    _photoimage=seleetImage;
    

    
    if (_photobutton==nil) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
                           
        button.layer.cornerRadius=5;
        button.frame=CGRectMake(5, 30, 25, 25);
        
        button.layer.masksToBounds=YES;
     
        _photobutton=button;
        
        [button addTarget:self action:@selector(photoclick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * but1=[_butarray objectAtIndex:0];
        UIButton * but2=[_butarray objectAtIndex:1];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            //方便恢复距离
            but1.transform=CGAffineTransformTranslate(but1.transform, 20, 0);
            but2.transform=CGAffineTransformTranslate(but2.transform, 5, 0);
            
            
        }];
        
    }
    

    [_photobutton setImage:seleetImage forState:UIControlStateNormal];
    
    [_toolView addSubview:_photobutton];
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    

}

//放大选择的图片
-(void)photoclick:(UIButton *)button
{
    
    [_textView resignFirstResponder];
    

    if (_photoImageBigView==nil) {
        _photoImageBigView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        _photoImageBigView.backgroundColor=[UIColor blackColor];
    
        _photoImageBigView.userInteractionEnabled=YES;
        _photoImageBigView.contentMode=UIViewContentModeScaleAspectFit;
        
        [_photoImageBigView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(narrowImage:)]];
        
        UIButton * delbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [delbutton setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
        [delbutton addTarget:self action:@selector(delimage:) forControlEvents:UIControlEventTouchUpInside];
        delbutton.tag=103;
        delbutton.frame=CGRectMake(ScreenWidth-40, 40, 20,26);
        delbutton.hidden=YES;
        [_photoImageBigView addSubview:delbutton];
        
    }
    
    _photoImageBigView.frame=CGRectMake(5, ScreenHeight-240, 20, 20);
    //判断有没有父视图
    if (![_photoImageBigView superview]) {
        _photoImageBigView.image=self.photoimage;
        [self.view.window addSubview:_photoImageBigView];
 
        [UIView animateWithDuration:1 animations:^{
        
            _photoImageBigView.frame=CGRectMake(0,0,ScreenWidth,ScreenHeight);

        
        } completion:^(BOOL finished){
        
            [UIApplication sharedApplication].statusBarHidden=YES;
            
            [_photoImageBigView viewWithTag:103].hidden=NO;
            
        }];
    }


}

//删除选中的图片
-(void)delimage:(UIButton *)button
{
    [self narrowImage:nil];
    
    
    [self.photobutton removeFromSuperview ];
    
    _photoimage=nil;
    
    _photobutton=nil;

    
    UIButton * but1=[_butarray objectAtIndex:0];
    UIButton * but2=[_butarray objectAtIndex:1];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        //方便恢复距离
        but1.transform=CGAffineTransformIdentity;
        but2.transform=CGAffineTransformIdentity;
        
    }];

}
//缩小选择的图片
-(void)narrowImage:(UITapGestureRecognizer *)gesture
{
    [_photoImageBigView viewWithTag:103].hidden=YES;

    [UIView animateWithDuration:0.4 animations:^{
        
        _photoImageBigView.frame=CGRectMake(5, ScreenHeight-240, 20, 20);

        //_photoImageBigView.hidden=YES;
        
    } completion:^(BOOL finished){
        
        [_photoImageBigView removeFromSuperview];
        
       
    }];
    [UIApplication sharedApplication].statusBarHidden=NO;
    
    [self.textView becomeFirstResponder];

}


- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{

//    if ([_request.tag intValue]==100) {
//
//        [super showStatusView:NO title:@"发送成功"];
//
//        [self disView];
// 
//    }

}


//toolbar按钮点击
-(void)butclick:(UIButton*)button
{
    
    

    if(button.tag==101){
        
        //发布微博

        NSString * weibo_text= self.textView.text;
        
        if (weibo_text.length>0) {
            
            [super showStatusView:YES title:@"发送中"];

            NSMutableDictionary *  params=[NSMutableDictionary dictionaryWithObject:weibo_text forKey:@"status"];
            
            if (self.latitude.length>0) {
                [params setObject:self.latitude forKey:@"lat"];
            }
            if (self.longitude.length>0) {
                [params setObject:self.longitude forKey:@"long"];
            }
            
            //不带图
            if (_photoimage == nil) {
                
                [NetRequest requestWithBlock:@"statuses/update.json" httpMethod:@"POST"  params:params completeBlock:^(id result) {
                   
                    [super showStatusView:NO title:@"发送成功"];
                    
                    [self disView];
                    
                    
                }];
                
                
                
//                  [self.sinaweibo requestWithTAG:@"statuses/update.json" params:params httpMethod:@"POST" tag:@"100" delegate:self];
                
            }else{
                
                NSData *imagedata=UIImageJPEGRepresentation(_photoimage, 0.3);
                
                [params setObject:imagedata forKey:@"pic"];
                
                [NetRequest requestWithBlock:@"statuses/upload.json" httpMethod:@"POST"  params:params completeBlock:^(id result) {
                    
                    [super showStatusView:NO title:@"发送成功"];
                    
                    [self disView];
                    
                    
                }];

                
                
                
            //带图
//                  [self.sinaweibo requestWithTAG:@"statuses/upload.json" params:params httpMethod:@"POST" tag:@"100" delegate:self];
            
            }
            
            
          

            
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
