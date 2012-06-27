//
//  CheckboxImageView.h
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckboxImageView;

@protocol CheckboxImageViewDelegate <NSObject>

- (void)CheckboxImage:(CheckboxImageView *)checkbox;

@end

@interface CheckboxImageView : UIImageView
{
    UIImage *normalImage;
    UIImage *checkedImage;
}


@property (nonatomic, assign) NSInteger rowIndex;
@property (nonatomic, assign) id<CheckboxImageViewDelegate> delegate;

- (void)setNormalImage:(UIImage*)nImage andCheckedImage:(UIImage*)cImage;



@end
