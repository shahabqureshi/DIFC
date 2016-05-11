//
//  RegisterViewController.h
//  RaffleDrawGlobalVillage
//
//  Created by Shahab Qureshi on 11/17/15.
//  Copyright (c) 2015 gtechme. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    KnowAboutTextField,
    MostAttractiveTextField,
    LeastAttractiveTextField,
    RankDIFCTextField,
    ComparableExperienceTextField,
    InterestedInTextField
    
} DropDownTextField;

@interface RegisterViewController : UIViewController <UIPopoverControllerDelegate>
{
    NSTimer *TIMER;
    
    DropDownTextField TextFieldName;
}
@property(nonatomic, retain) UIPopoverController *popOverController;

@property(nonatomic, retain) NSArray *TicketsArray;

- (IBAction)didTapRegisterButtons:(id)sender;
- (IBAction)didTapBGButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *knowAboutTextField;
@property (weak, nonatomic) IBOutlet UITextField *mostAttractiveTextField;
@property (weak, nonatomic) IBOutlet UITextField *leastAttractiveTextField;
@property (weak, nonatomic) IBOutlet UITextField *rankDIFCTextField;
@property (weak, nonatomic) IBOutlet UITextField *comparableExperienceTextField;
@property (weak, nonatomic) IBOutlet UITextField *interestedInTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;

// MANUAL ENTRY
@property (weak, nonatomic) IBOutlet UIView *manualEntryView;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;

- (IBAction)didTapManualEntryButtons:(id)sender;
- (IBAction)didTapBackButton:(id)sender;


-(void)SelectedOTher:(int)T_A_G andSelectedText:(NSString *)selectedText;

@property (weak, nonatomic) IBOutlet UIView *whiteBGView;
@end
