//
//  TravelChecklistViewController.m
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "TravelChecklistViewController.h"
#import "TravelMOC.h"

#import "TravelTodoList.h"
#import "TravelTodoListCell.h"

#import "TravelTodoItemsViewController.h"

#import "TravelNewChecklistViewController.h"

#import "JKNavigationBar.h"

@interface TravelChecklistViewController ()


- (void)configureCell:(TravelTodoListCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation TravelChecklistViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize tableView = _tableView;

@synthesize moc = _moc;
@synthesize tmpCell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Your List";
    
    
    
 
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"nav-plus-btn.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(newChecklistClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
    // Core Data Setup
    _moc = [[TravelMOC instance] managedObjectContext];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    
    
//        TravelTodoList *toDoList = [NSEntityDescription insertNewObjectForEntityForName:@"Travel_TodoList" inManagedObjectContext:_moc];
//        
//        toDoList.title = @"Hello, World";
//        [[TravelMOC instance] saveContext];
    
   
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];

    [super viewDidUnload];
    [self setFetchedResultsController:nil];
    [self setMoc:nil];
    [self setTmpCell:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - core data

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Travel_TodoList" inManagedObjectContext:_moc];
    [fetchRequest setEntity:entity];
    
    
    

    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"created_date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_moc sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(TravelTodoListCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TravelTodosCell";
    
    TravelTodoListCell *cell = (TravelTodoListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TravelTodoListCell" owner:self options:nil];
        cell = tmpCell;
        tmpCell = nil;
    }
    
    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(TravelTodoListCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    TravelTodoList *todoList = [_fetchedResultsController objectAtIndexPath:indexPath];

    cell.titleTextLabel.text = todoList.title;
    cell.countTextLabel.text = [NSString stringWithFormat:@"%d",todoList.todoItems.count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        TravelTodoList *todo = [_fetchedResultsController objectAtIndexPath:indexPath];
        [_moc deleteObject:todo];
        [[TravelMOC instance] saveContext];
    }    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelTodoItemsViewController *todosView = [[TravelTodoItemsViewController alloc] initWithNibName:@"TravelTodoItemsViewController" bundle:nil];
    todosView.parentList = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    
    [self.navigationController pushViewController:todosView animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)newChecklistClicked:(id)sender {
    
    TravelNewChecklistViewController *newList = [[TravelNewChecklistViewController alloc] initWithNibName:@"TravelNewChecklistViewController" bundle:nil];
    
     UINavigationController *jkNavVC = [[[NSBundle mainBundle] loadNibNamed:@"JKNavigationBarController" owner:self options:nil] objectAtIndex:0];
    
    jkNavVC.viewControllers = [NSArray arrayWithObjects:newList, nil];    
    
    JKNavigationBar *jkBar = (JKNavigationBar*) jkNavVC.navigationBar;
    [jkBar setBackgroundImage:[UIImage imageNamed:@"nav-overlay.png"]];
    [jkBar setBackgroundColor:[UIColor colorWithHue:0 saturation:0.62 brightness:0.43 alpha:1.0]];
    
    
    [self presentModalViewController:jkNavVC animated:YES];
    
}

- (IBAction)popView:(id)sender {

    
    [self.navigationController popViewControllerAnimated:YES];
}




@end

