//
//  TravelTodoItemsViewController.m
//  UnityDriven
//
//  Created by n3tr on 5/24/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "TravelTodoItemsViewController.h"
#import "TravelTodoItemsCell.h"
#import "TravelMOC.h"

#import "TravelTodoItem.h"
#import "TravelTodoList.h"

#import "TravelTodoDetailViewController.h"

@interface TravelTodoItemsViewController ()

- (void)configureCell:(TravelTodoItemsCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation TravelTodoItemsViewController
@synthesize tableView = _tableView;
@synthesize tmpCell;
@synthesize moc = _moc;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize parentList;
@synthesize addNewTodoButtonClicked = _addNewTodoButtonClicked;
@synthesize quickTaskField = _quickTaskField;
@synthesize navPlusBtn = _navPlusBtn;
@synthesize quickTaskBtn = _quickTaskBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [NSFetchedResultsController deleteCacheWithName:@"TravelChecklist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Tasks";
    
    //Bar Button
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"nav-back-btn.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"nav-plus-btn.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(newEntry:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
    // Do any additional setup after loading the view from its nib.
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    
    
    // Core Data Setup
    _moc = [[TravelMOC instance] managedObjectContext];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    

//    TravelTodoItem *todoItem = [NSEntityDescription insertNewObjectForEntityForName:@"Travel_TodoItem" inManagedObjectContext:_moc];
//    
//    todoItem.title = @"Todo Item";
//    todoItem.isDone = [NSNumber numberWithBool:NO];
//    todoItem.parentList = parentList;
//
//    [[TravelMOC instance] saveContext];
    
    
}

- (void)viewDidUnload
{
    [self setTmpCell:nil];
    [self setTableView:nil];
    [self setAddNewTodoButtonClicked:nil];
    [self setQuickTaskField:nil];
    [self setNavPlusBtn:nil];
    [self setQuickTaskBtn:nil];
    [super viewDidUnload];
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
                                   entityForName:@"Travel_TodoItem" inManagedObjectContext:_moc];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.parentList == %@",parentList];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"isDone" ascending:YES];
    NSSortDescriptor *sortDate = [[NSSortDescriptor alloc]
                              initWithKey:@"created_date" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort,sortDate,nil]];
    
    [fetchRequest setFetchBatchSize:30];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_moc sectionNameKeyPath:@"isDone"
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
            [self configureCell:(TravelTodoItemsCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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


#pragma mark - TableView Delegate



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 290, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = [[sectionInfo name] isEqualToString:@"0"] ? @"Active Tasks" : @"Complete Tasks";    
    [headerView addSubview:label];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TravelTodoCell";
    
    TravelTodoItemsCell *cell = (TravelTodoItemsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TravelTodoItemsCell" owner:self options:nil];
        cell = tmpCell;
        tmpCell = nil;
    }
    
   
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
    
    [self configureCell:cell atIndexPath:indexPath];

    cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
}

- (void)configureCell:(TravelTodoItemsCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TravelTodoItem *todos = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.cellIndexPath = indexPath;
    cell.rowNumber = indexPath.row;
    cell.sectionNumber = indexPath.section;
    cell.delegate = self;
    
    cell.checkboxImageView.image = [todos.isDone boolValue] ? [UIImage imageNamed:@"tv-todolist-checked.png"] : [UIImage imageNamed:@"tv-todolist-check.png"];
    cell.checked = [todos.isDone boolValue];
    cell.titleTextLabel.text = todos.title;
    
       
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelTodoItem *todo = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    TravelTodoDetailViewController *detailVC = [[TravelTodoDetailViewController alloc] initWithNibName:@"TravelTodoDetailViewController" bundle:nil];
    detailVC.todoItem = todo;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TravelTodoItem *todo = [_fetchedResultsController objectAtIndexPath:indexPath];
        [_moc deleteObject:todo];
        [[TravelMOC instance] saveContext];
    }
}



- (void)todoItemDidCheckedAtIndexPath:(NSIndexPath *)cellIndexPath inCell:(UITableViewCell *)todoCell
{
    
   
    NSIndexPath *foo = [_tableView indexPathForCell:todoCell];
    
     NSLog(@"sec:%d - row:%d",foo.section,foo.row);
    TravelTodoItem *todoItem = [_fetchedResultsController objectAtIndexPath:foo];
    BOOL checked = [todoItem.isDone boolValue];
     todoItem.isDone = [NSNumber numberWithBool:!checked];
    [[TravelMOC instance] saveContext];
}

- (void)todoItemDidCheckedAtRow:(NSInteger)rowNum inSection:(NSInteger)sectionNum
{
      NSLog(@"sec:%d - row:%d",sectionNum,rowNum);
    
    NSIndexPath *foo = [NSIndexPath indexPathForRow:rowNum inSection:sectionNum];

    TravelTodoItem *todoItem = [_fetchedResultsController objectAtIndexPath:foo];
    BOOL checked = [todoItem.isDone boolValue];
    todoItem.isDone = [NSNumber numberWithBool:!checked];
    [[TravelMOC instance] saveContext];

}

- (IBAction)popView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _quickTaskField) {
        NSString *taskText = _quickTaskField.text;
        NSString *trimmedString = [taskText stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        
        if (trimmedString.length == 0) {
            _quickTaskField.text = @"";
            [textField resignFirstResponder];
            return YES;
        }
        
    TravelTodoItem *todoItem = [NSEntityDescription insertNewObjectForEntityForName:@"Travel_TodoItem" inManagedObjectContext:_moc];
    
    todoItem.title = taskText;
    todoItem.created_date = [NSDate date];
    todoItem.isDone = [NSNumber numberWithBool:NO];
    todoItem.parentList = parentList;

    [[TravelMOC instance] saveContext];

    _quickTaskField.text = @"";
    [textField resignFirstResponder];

        
    }

    return YES;
}



- (IBAction)newEntry:(id)sender {
    TravelTodoDetailViewController *newTodo = [[TravelTodoDetailViewController alloc] initWithNibName:@"TravelTodoDetailViewController" bundle:nil];
    
    newTodo.parentList = parentList;
    newTodo.newEntry = YES;
    [self.navigationController pushViewController:newTodo animated:YES];
}

- (IBAction)plusBtnClicked:(id)sender {
    [_quickTaskField becomeFirstResponder];
    
}


@end
