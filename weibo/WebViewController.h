//
//  WebViewController.h
//  weibo
//
//  Created by laijiawei on 14-4-4.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>
{

    NSString * _url;

}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

-initwithUrl:(NSString *)url;
- (IBAction)goahead:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)goback:(id)sender;
@end
