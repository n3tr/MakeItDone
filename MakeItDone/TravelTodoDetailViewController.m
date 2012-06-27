//
//  TravelTodoDetailViewController.m
//  UnityDriven
//
//  Created by n3tr on 5/27/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "TravelTodoDetailViewController.h"
#import "TravelMOC.h"


@interface TravelTodoDetailViewController ()

@end

@implementation TravelTodoDetailViewController
@synthesize titleField;
@synthesize descField;
@synthesize titleWrapperView;
@synthesize descWrapperView;
@synthesize isDoneBtn;
@synthesize todoItem;
@synthesize customTitle;
@synthesize newEntry;
@synthesize parentList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    customTitle.text = title;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (newEntry) {
        [titleField becomeFirstResponder];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"nav-back-btn.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    
    if (todoItem) {
        [todoItem.isDone boolValue] ? [isDoneBtn setImage:[UIImage imageNamed:@"tv-todolist-checked.png"] forState:UIControlStateNormal] : [isDoneBtn setImage:[UIImage imageNamed:@"tv-todolist-check.png"] forState:UIControlStateNormal];
        
        titleField.text = todoItem.title;
        descField.text = todoItem.detail;
    }else {
        newEntry = YES;
        self.title = @"New Task";
        
    }
    
    
}

- (void)viewDidUnload
{
    [self setTitleField:nil];
    [self setDescField:nil];
    [self setTitleWrapperView:nil];
    [self setDescWrapperView:nil];
    [self setIsDoneBtn:nil];
    [self setCustomTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)toggleIsDone:(id)sender {
    BOOL isDone = [todoItem.isDone boolValue];
    todoItem.isDone = [NSNumber numberWithBool:!isDone];
    
    [todoItem.isDone boolValue] ? [isDoneBtn setImage:[UIImage imageNamed:@"tv-todolist-checked.png"] forState:UIControlStateNormal] : [isDoneBtn setImage:[UIImage imageNamed:@"tv-todolist-check.png"] forState:UIControlStateNormal];
}

- (IBAction)popView:(id)sender {
    
    
    if (newEntry) {
        if ([[titleField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title cannot be blank" message:nil delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            
            [alert show];
            return;
        } else {
            TravelTodoItem *todo = [NSEntityDescription insertNewObjectForEntityForName:@"Travel_TodoItem" inManagedObjectContext:[[TravelMOC instance] managedObjectContext]];
            todo.title = titleField.text;
            todo.detail = descField.text;
            todo.parentList = parentList;
            todo.isDone = [NSNumber numberWithBool:NO];
            todo.created_date = [NSDate date];
            [[TravelMOC instance] saveContext];
            [self.navigationController popViewControllerAnimated:YES];
        }
    
       
    } else {
        todoItem.title = titleField.text;
        todoItem.detail = descField.text;
        
        
        [[TravelMOC instance] saveContext];
        [self.navigationController popViewControllerAnimated:YES];
    }
        
    
}
@end
