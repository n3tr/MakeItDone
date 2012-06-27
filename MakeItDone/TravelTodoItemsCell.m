//
//  TravelTodoItemsCell.m
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "TravelTodoItemsCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TravelTodoItemsCell
@synthesize checkboxImageView;
@synthesize titleTextLabel;
@synthesize contentSubview;
@synthesize delegate;
@synthesize cellIndexPath;
@synthesize rowNumber, sectionNumber;

@synthesize checked = _checked;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
   
    
    self.checkboxImageView.delegate = self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)CheckboxImage:(CheckboxImageView *)checkbox
{
   
    [delegate todoItemDidCheckedAtIndexPath:nil inCell:self];
//    [delegate todoItemDidCheckedAtRow:rowNumber inSection:sectionNumber];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews]; 
    
    if (!_checked) {
        self.contentSubview.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.contentSubview.layer.shadowOpacity = 0.2;
        self.contentSubview.layer.shadowRadius = 1;
        self.contentSubview.layer.shadowOffset = CGSizeMake(1,1);
        self.contentSubview.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentSubview.bounds].CGPath;
        self.contentSubview.layer.masksToBounds = NO;
        
        self.contentSubview.layer.borderColor = [[UIColor colorWithWhite:0.95 alpha:1.0] CGColor];
        self.contentSubview.layer.borderWidth = 0;
        self.titleTextLabel.textColor = [UIColor darkGrayColor];
        
    } else {
        self.contentSubview.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.contentSubview.layer.shadowOpacity = 0;
        self.contentSubview.layer.shadowRadius = 0;
        self.contentSubview.layer.shadowOffset = CGSizeZero;
        self.contentSubview.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentSubview.bounds].CGPath;
        self.contentSubview.layer.masksToBounds = NO;
        
        self.contentSubview.layer.borderColor = [[UIColor colorWithWhite:0.95 alpha:1.0] CGColor];
        self.contentSubview.layer.borderWidth = 1;
        self.titleTextLabel.textColor = [UIColor grayColor];
    }
}

@end
