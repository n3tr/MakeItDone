//
//  JKNavigationBar.m
//  Zerber
//
//  Created by n3tr on 5/10/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "JKNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

@interface JKNavigationBar()
{
    UIView *bgView;
    UIColor *_bgColor;
    UIImage *_bgImage;
}

@end

@implementation JKNavigationBar

- (void)drawRect:(CGRect)rect
{
//    CGRect bgRect =  CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _bgColor = [UIColor colorWithRed:0/255.0 green:84/255.0 blue:154/255.0 alpha:1.0];
    if(_bgColor)
    {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColor(context, CGColorGetComponents( [_bgColor CGColor]));
        CGContextFillRect(context, rect);
        [self setTintColor:_bgColor];
    }
    
    if (_bgImage) {
        
        //        // Draw Image if need
        //        UIImageView *imageView = [[UIImageView alloc] initWithImage:_bgImage];
        //        imageView.frame = bgRect;
        //        [self insertSubview:imageView atIndex:0];
        
        [_bgImage drawInRect:rect];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _bgColor = backgroundColor;
    [self setNeedsDisplay];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _bgImage = backgroundImage;
    [self setNeedsDisplay];
}







@end
