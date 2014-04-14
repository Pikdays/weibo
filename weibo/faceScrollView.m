//
//  faceScrollView.m
//  weibo
//
//  Created by laijiawei on 14-4-11.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "faceScrollView.h"

@implementation faceScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(id)initWithSelectBlock:(selectBlock)block
{
    self=[self initWithFrame:CGRectZero];
    
    if (self!=nil) {
        
         _faceview.block=block;
    }
    
    return self;
}

-(void)initView
{
    _faceview=[[faceView alloc]initWithFrame:CGRectZero];
    
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320,_faceview.height)];
    
    _scrollview.backgroundColor=[UIColor clearColor];
    
    
    _scrollview.contentSize=CGSizeMake(_faceview.width, _faceview.height);
    
    _scrollview.pagingEnabled=YES;
    
    _scrollview.showsHorizontalScrollIndicator=NO;
    
    _scrollview.clipsToBounds=NO;
    
    [_scrollview addSubview:_faceview];

    _scrollview.delegate=self;
    
    [self addSubview:_scrollview];
    
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((ScreenWidth-40)/2, _scrollview.bottom, 40, 20)];
    
    _pageControl.numberOfPages=4;
    
    _pageControl.currentPage=0;
    
    _pageControl.backgroundColor=[UIColor clearColor];
    
    
    self.height=_scrollview.height+_pageControl.height;
    
    self.width=_scrollview.width;
    
    [self addSubview:_pageControl];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int pageNumber=_scrollview.contentOffset.x/ScreenWidth;
    
    _pageControl.currentPage=pageNumber;


}

-(void)drawRect:(CGRect)rect
{

    [[UIImage imageNamed:@"emoticon_keyboard_background.png"]drawInRect:rect];

}

@end
