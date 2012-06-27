//
//  TravelTodoItemsCell.h
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CheckboxImageView.h"


@class TravelTodoItemsCell;


@protocol TravelTodoItemCellDelegate <NSObject>

- (void)todoItemDidCheckedAtIndexPath:(NSIndexPath *)cellIndexPath inCell:(UITableViewCell *)todoCell;

- (void)todoItemDidCheckedAtRow:(NSInteger)rowNum inSection:(NSInteger)sectionNum;

@end

@interface TravelTodoItemsCell : UITableViewCell
<CheckboxImageViewDelegate>


@property (weak, nonatomic) IBOutlet CheckboxImageView *checkboxImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UIView *contentSubview;

@property (nonatomic, assign) BOOL checked;

@property (nonatomic, assign) NSIndexPath *cellIndexPath;
@property (nonatomic, assign) id<TravelTodoItemCellDelegate> delegate;

@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, assign) NSInteger rowNumber;


- (void)setChecked:(BOOL)_checked;

@end
