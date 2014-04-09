//
//  faceView.m
//  weibo
//
//  Created by laijiawei on 14-4-8.
//  Copyright (c) 2014年 laijiawei. All rights reserved.
//

#import "faceView.h"
#define item_width 42
#define item_height 45

@implementation faceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self init_data];
        
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)init_data
{

    //封装二维数组
    items=[NSMutableArray array];
    
   NSString * path= [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    
    NSArray * array=[NSArray arrayWithContentsOfFile:path];
    NSMutableArray * item=nil;
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic=[array objectAtIndex:i];
        if (i%28==0) {
            item=[NSMutableArray arrayWithCapacity:28];
            
            [items addObject:item];
        }
        
        [item addObject:dic];
    }
    
    //设置尺寸
    self.width=items.count*ScreenWidth;
    self.height=item_height*4;
    
    _enlargeView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 92)];
    
    _enlargeView.image=[UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
    
    _enlargeView.hidden=YES;
    _enlargeView.backgroundColor=[UIColor clearColor];
    [self addSubview:_enlargeView];
    
    UIImageView * faceitem=[[UIImageView alloc]initWithFrame:CGRectMake((64-30)/2, 15, 30, 30)];
    faceitem.backgroundColor=[UIColor clearColor];
    faceitem.tag=100;
    [_enlargeView addSubview:faceitem];
    
    
}

-(void)drawRect:(CGRect)rect
{
    //  行  列
    int row=0,column=0;
    
    for (int i=0; i<items.count; i++) {
        
        NSArray * item=[items objectAtIndex:i];
    
        for (int j=0; j<item.count; j++) {
            
            NSDictionary * dic=[item objectAtIndex:j];
            NSString * imagePath=[dic objectForKey:@"png"];
            
            UIImage * image=[UIImage imageNamed:imagePath];
            
            //要考虑页数
            CGRect frame=CGRectMake(item_width*column+(i*ScreenWidth)+15, item_height*row+15, 30, 30);
            
            //重要的一部，画表情
            [image drawInRect:frame];
            
            column++;
            
            if (column%7==0) {
                row++;
                column=0;
            }
            if (row==4) {
                row=0;
            }
            
        }
        
    
    }

}
-(void)touchpoint:(CGPoint)point
{

    int x=point.x;
    
    int y=point.y;
    
    int p=x/ScreenWidth;//页数
    
    
    int row= (y-15)/item_height;//行
    
    int column= (x-15-ScreenWidth*p)/item_width;//列
    
    //防止数组越界
    if (column>6) {
        column=6;
    }
    if (column<0) {
        column=0;
    }
    if (row>3) {
        row=3;
    }
    if (row<0) {
        row=0;
    }
    int index=row*7+column;
    
    
    NSString * faceimage=[items[p][index] objectForKey:@"png"];
    

    
    //性能优化
    if (![faceimage isEqualToString:_selectImageName] || _selectImageName==nil) {
        
        UIImageView * faceitem=(UIImageView *)[_enlargeView viewWithTag:100];
        
        faceitem.image=[UIImage imageNamed:faceimage];
        
        _selectImageName=faceimage;
        
        _enlargeView.hidden=NO;
        
        
        _enlargeView.left=item_width*column+(p*ScreenWidth);
        
        _enlargeView.bottom=item_height*row+30;
        
    }


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:self];

    [self touchpoint:point];
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView * view=(UIScrollView *)self.superview;
        view.scrollEnabled=NO;
    }
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch=[touches anyObject];
    
    CGPoint point=[touch locationInView:self];
    
    [self touchpoint:point];

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    _enlargeView.hidden=YES;

    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView * view=(UIScrollView *)self.superview;
        view.scrollEnabled=YES;
    }

}
@end
