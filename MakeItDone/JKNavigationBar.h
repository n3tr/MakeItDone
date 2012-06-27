//
//  JKNavigationBar.h
//  Zerber 
//
//  Class :
//  This class use for customize NavigationBar Background for Solid Color or UIImage
//  If needs gradient is using default navBar
//
//  Created by n3tr on 5/10/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKNavigationBar : UINavigationBar

- (void)setBackgroundColor:(UIColor *)backgroundColor;
- (void)setBackgroundImage:(UIImage *)backgroundImage;

@end
