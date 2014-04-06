//
//  WebViewController.m
//  weibo
//
//  Created by laijiawei on 14-4-4.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(id)initwithUrl:(NSString *)url{
    [super init];
    if (self!=nil) {
        _url=[url copy];
    }
   return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_url!=nil) {
        NSURLRequest * request= [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
        
        [_webView loadRequest:request];
        
        self.title=@"正在加载...";
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    }
    

    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView

{

    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    

}

- (IBAction)goahead:(id)sender {
    
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (IBAction)refresh:(id)sender {
    [_webView reload];
}

- (IBAction)goback:(id)sender {
    
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
