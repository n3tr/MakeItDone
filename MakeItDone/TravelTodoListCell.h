//
//  TravelTodoListCell.h
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelTodoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentSubview;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *countTextLabel;

@property (nonatomic, assign) NSInteger rowNumber;

@end
