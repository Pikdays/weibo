//
//  SendViewController.h
//  weibo
//
//  Created by laijiawei on 14-4-5.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"
#import "faceScrollView.h"

@interface SendViewController : BaseViewController<SinaWeiboRequestDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIView *toolView;

@property(nonatomic,retain)NSMutableArray * butarray;

@property(nonatomic,copy)NSString * latitude;
@property(nonatomic,copy)NSString * longitude;

@property(nonatomic,retain)UIImage * photoimage;

@property(nonatomic,retain)UIButton * photobutton;

@property(nonatomic,retain)UIImageView * photoImageBigView;


@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UIView *placeView;

@property(nonatomic,retain) faceScrollView * face;

@end
