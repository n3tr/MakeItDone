//
//  CheckboxImageView.m
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "CheckboxImageView.h"

@implementation CheckboxImageView

@synthesize rowIndex;
@synthesize delegate;




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
   
    
    
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate CheckboxImage:self];
}

- (void)toggle
{
    
}

- (void)setNormalImage:(UIImage *)nImage andCheckedImage:(UIImage *)cImage
{
    normalImage = nImage;
    checkedImage = cImage;
    
}







@end
