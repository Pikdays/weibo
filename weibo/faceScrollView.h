//
//  faceScrollView.h
//  weibo
//
//  Created by laijiawei on 14-4-11.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faceView.h"
@interface faceScrollView : UIView<UIScrollViewDelegate>
{

    UIScrollView * _scrollview;
    
    faceView * _faceview;
    
    UIPageControl *_pageControl;

}
-(id)initWithSelectBlock:(selectBlock)block;
@end
