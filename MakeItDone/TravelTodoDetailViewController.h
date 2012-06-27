//
//  TravelTodoDetailViewController.h
//  UnityDriven
//
//  Created by n3tr on 5/27/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelTodoItem.h"
#import "TravelTodoList.h"
@interface TravelTodoDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *descField;
@property (weak, nonatomic) IBOutlet UIView *titleWrapperView;
@property (weak, nonatomic) IBOutlet UIView *descWrapperView;
@property (weak, nonatomic) IBOutlet UIButton *isDoneBtn;
@property (nonatomic, retain) TravelTodoItem *todoItem;

@property (weak, nonatomic) IBOutlet UILabel *customTitle;
@property (nonatomic,assign) BOOL newEntry;

@property ( nonatomic, retain) TravelTodoList *parentList;

- (IBAction)toggleIsDone:(id)sender;
- (IBAction)popView:(id)sender;

@end
