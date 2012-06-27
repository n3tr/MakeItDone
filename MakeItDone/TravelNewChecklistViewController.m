//
//  TravelNewChecklistViewController.m
//  UnityDriven
//
//  Created by n3tr on 5/27/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import "TravelNewChecklistViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "TravelTodoList.h"
#import "TravelMOC.h"

@interface TravelNewChecklistViewController ()

@end

@implementation TravelNewChecklistViewController
@synthesize titleWrapperView;
@synthesize titleField;
@synthesize saveBtnClicked;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [titleField becomeFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"New List";
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"nav-back-btn.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    // Wrapper Shadow
    titleWrapperView.layer.borderColor = [[UIColor colorWithHue:0 saturation:0 brightness:0.8 alpha:1.0] CGColor];
    titleWrapperView.layer.borderWidth = 1;
    titleWrapperView.layer.shadowColor = [[UIColor blackColor] CGColor];
    titleWrapperView.layer.shadowOffset = CGSizeMake(0, 0);
    titleWrapperView.layer.shadowOpacity = 0.1;
    titleWrapperView.layer.shadowRadius = 1;
}

- (void)viewDidUnload
{
  
    [self setTitleWrapperView:nil];
    [self setTitleField:nil];
    [self setSaveBtnClicked:nil];
    [super viewDidUnload];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [titleField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveButtonClicked:(id)sender {
    
    NSString *titleText = [titleField text];
    if ([[titleText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title cannot be Blank" message:nil delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        
        [alert show];
        alert = nil;
    } else {
        NSManagedObjectContext *_moc = [[TravelMOC instance] managedObjectContext];
        TravelTodoList *toDoList = [NSEntityDescription insertNewObjectForEntityForName:@"Travel_TodoList" inManagedObjectContext:_moc];
        
        toDoList.title = titleText;
        toDoList.created_date = [NSDate date];
        [[TravelMOC instance] saveContext];
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)popView:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
