//
//  TravelTodoItemsViewController.h
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TravelTodoItemsCell.h"

#import <CoreData/CoreData.h>

@class TravelTodoList;

@interface TravelTodoItemsViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,
TravelTodoItemCellDelegate, NSFetchedResultsControllerDelegate,
UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet TravelTodoItemsCell *tmpCell;
- (IBAction)popView:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSManagedObjectContext* moc;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) TravelTodoList *parentList;

@property (weak, nonatomic) IBOutlet UIButton *addNewTodoButtonClicked;
@property (weak, nonatomic) IBOutlet UITextField *quickTaskField;
@property (weak, nonatomic) IBOutlet UIButton *navPlusBtn;
@property (weak, nonatomic) IBOutlet UIButton *quickTaskBtn;

- (IBAction)newEntry:(id)sender;

- (IBAction)plusBtnClicked:(id)sender;

@end
