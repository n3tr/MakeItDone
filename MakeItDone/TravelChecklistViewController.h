//
//  TravelChecklistViewController.h
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class TravelTodoListCell;

@interface TravelChecklistViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext* moc;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) IBOutlet TravelTodoListCell *tmpCell;

- (IBAction)newChecklistClicked:(id)sender;

- (IBAction)popView:(id)sender;
@end
