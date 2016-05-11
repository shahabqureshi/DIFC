//
//  SearchFilterViewController.h
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/21/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFilterViewController : UIViewController <UIPopoverControllerDelegate>{
    
    NSArray *registeredContacts;
    UIPopoverController *popoverController;
}

@property (retain, nonatomic) UIPopoverController *popoverController;
@property (retain, nonatomic) UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *fromDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *toDateTextField;

@property (weak, nonatomic) IBOutlet UIView *selectDateView;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

- (IBAction)didTapFilterButton:(id)sender;
- (IBAction)didTapExportButton:(id)sender;
- (IBAction)didTapBackButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;

@end
