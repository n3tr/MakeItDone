//
//  TravelNewChecklistViewController.h
//  UnityDriven
//
//  Created by n3tr on 5/27/55 BE.
//  Copyright (c) 2555 Simpletail. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TravelNewChecklistViewController : UIViewController
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *titleWrapperView;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnClicked;

- (IBAction)saveButtonClicked:(id)sender;

- (IBAction)popView:(id)sender;

@end
