//
//  TravelTodoListCell.m
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "TravelTodoListCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TravelTodoListCell
@synthesize contentSubview;
@synthesize titleTextLabel;
@synthesize countTextLabel;
@synthesize rowNumber;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)awakeFromNib
{
    titleTextLabel.textColor = [UIColor darkGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentSubview.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.contentSubview.layer.shadowOpacity = 0.2;
    self.contentSubview.layer.shadowRadius = 1;
    self.contentSubview.layer.shadowOffset = CGSizeMake(1,1);
    self.contentSubview.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentSubview.bounds].CGPath;
    self.contentSubview.layer.masksToBounds = NO;
    

}

@end
