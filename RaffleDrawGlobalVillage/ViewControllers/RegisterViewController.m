//
//  RegisterViewController.m
//  RaffleDrawGlobalVillage
//
//  Created by Shahab Qureshi on 11/17/15.
//  Copyright (c) 2015 gtechme. All rights reserved.
//

#import "RegisterViewController.h"
#import "FinalViewController.h"
#import "ListPopOverController.h"

#import <CoreData/CoreData.h>
#import "DataLayer.h"

#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789&:-_.@،ىورزدذطظءةكمنتالبيشجحخهعغفقثصض١٢٣٤٥٦٧٨٩٠.@سةإأٱآَ "
@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize popOverController;
@synthesize TicketsArray;

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)POpToRoot {
    
    
}

-(void)NoActivityGoHome {
    
    [self.popOverController dismissPopoverAnimated:YES];
    [self removeAnimate:self.manualEntryView];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    [self performSelector:@selector(POpToRoot) withObject:nil afterDelay:0.5];
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [TIMER invalidate];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self startTimer];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeAnimate:self.manualEntryView];
}

- (void)didReceiveMemoryWarning {
   
    [super didReceiveMemoryWarning];
}

-(NSString *)getDateTimeInFormat{
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/Y hh:mm:ss a"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    return dateString;
}

-(NSString *)returnStringWithoutCommas:(NSString *)txtString {
    
    NSString *txt = [txtString stringByReplacingOccurrencesOfString:@","
                                                         withString:@"=="];
    
    txt = [txt stringByReplacingOccurrencesOfString:@"'"
                                         withString:@"[]"];
    return txt;
}

- (void)Save_DB {
    
    BOOL result = [DataLayer AddNewApplicant:[NSString stringWithFormat:@"INSERT into CustomerSurvey(knowAboutDIFC, mostAttractive, leastAttractive, rankDIFC, comparableExperienceToDIFC, interestedInService, emailAddress,UDID,deviceName,DateTime) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",[self returnStringWithoutCommas:self.knowAboutTextField.text],[self returnStringWithoutCommas:self.mostAttractiveTextField.text],[self returnStringWithoutCommas:self.leastAttractiveTextField.text],[self returnStringWithoutCommas:self.rankDIFCTextField.text],[self returnStringWithoutCommas:self.comparableExperienceTextField.text],[self returnStringWithoutCommas:self.interestedInTextField.text],[self returnStringWithoutCommas:self.emailAddressTextField.text],[UIDevice currentDevice].name,[[[UIDevice currentDevice] identifierForVendor] UUIDString], [self getDateTimeInFormat]]];
    
    if(result){
        
        // SAVE CHANGE & STORE
        [self EmptyAllTextFields];
        
        FinalViewController *final_vc = [[FinalViewController alloc] initWithNibName:@"FinalViewController" bundle:nil];
        [self.navigationController pushViewController:final_vc animated:YES];
        
    }else{
        [self showAlertViewWithMessage:@"There was an error in saving a data. Kindly try again later."];
        return;
    }
}

- (IBAction)didTapRegisterButtons:(id)sender {
    
    [TIMER invalidate];
    
    [self didTapBGButton:self];
    
    if([[self.knowAboutTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 || [[self.mostAttractiveTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 || [[self.leastAttractiveTextField.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 || [[self.rankDIFCTextField.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 || [[self.comparableExperienceTextField.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 || [[self.interestedInTextField.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ){
    
        [self showAlertViewWithMessage:@"Kindly fill in all fields."];
        return;
    }

    if([[self.emailAddressTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0){

        if([self isValidEmail:self.emailAddressTextField.text] == NO){
            
            [self showAlertViewWithMessage:@"Kindly enter a valid email address e.g abc@xyz.com"];
            return;
        }
    }
    
    [self Save_DB];
}

-(void) EmptyAllTextFields {
    
    [self.knowAboutTextField setText:@""];
    [self.mostAttractiveTextField setText:@""];
    [self.leastAttractiveTextField setText:@""];
    [self.rankDIFCTextField setText:@""];
    [self.comparableExperienceTextField setText:@""];
    [self.interestedInTextField setText:@""];
    [self.emailAddressTextField setText:@""];
}

-(void)startTimer {
    
    if(TIMER)
        [TIMER invalidate];
    
    TIMER = [NSTimer scheduledTimerWithTimeInterval:1*60
                                             target:self
                                           selector:@selector(NoActivityGoHome)
                                           userInfo:nil
                                            repeats:YES];
}

-(void) ResignAllResponders {
    
    [self.knowAboutTextField resignFirstResponder];
    [self.mostAttractiveTextField resignFirstResponder];
    [self.leastAttractiveTextField resignFirstResponder];
    [self.rankDIFCTextField resignFirstResponder];
    [self.comparableExperienceTextField resignFirstResponder];
    [self.interestedInTextField resignFirstResponder];
    [self.emailAddressTextField resignFirstResponder];
    [self.otherTextField resignFirstResponder];
}
- (IBAction)didTapBGButton:(id)sender {
    
    [self startTimer];
    
    [self ResignAllResponders];
}

-(BOOL)isValidEmail:(NSString*)text {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}


-(void) showAlertViewWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark - 
#pragma mark - POP OVER DELEGATE METHODS

-(void) showPopOverWithOptionsWithSourceArray:(NSMutableArray *)_sourceArray TextField:(UITextField *)txtField direction:(UIPopoverArrowDirection)arrowDirection height:(int) HEIGHT {
    
    [self didTapBGButton:self];
    
    ListPopOverController *tblLisView = [[ListPopOverController alloc]initWithObject:_sourceArray :self :txtField];
    [tblLisView setPreferredContentSize:CGSizeMake(txtField.frame.size.width, HEIGHT)];
    
    popOverController = [[UIPopoverController alloc]
                         initWithContentViewController:tblLisView];
    
    
    [popOverController presentPopoverFromRect:txtField.frame
                                       inView:self.whiteBGView
                     permittedArrowDirections:arrowDirection
                                     animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if([textField isEqual:self.knowAboutTextField]){
                
        NSMutableArray *coutriesArray = [NSMutableArray arrayWithObjects:@"News coverage",@"Website or social media",@"Business referrals ­ Please specify",@"Events or conferences",@"Other – Please specify",nil];
        [self showPopOverWithOptionsWithSourceArray:coutriesArray TextField:self.knowAboutTextField direction:UIPopoverArrowDirectionUp height:(int)[coutriesArray count]*44];
        return NO;
        
    }else if([textField isEqual:self.mostAttractiveTextField]){
        
        NSMutableArray *coutriesArray = [NSMutableArray arrayWithObjects:@"Legal framework",@"Reputation",@"Business clusters",@"Geographic connectivity",@"Community",@"Others?",nil];
        [self showPopOverWithOptionsWithSourceArray:coutriesArray TextField:self.mostAttractiveTextField direction:UIPopoverArrowDirectionUp height:(int)[coutriesArray count]*44];
        return NO;
        
    }else if([textField isEqual:self.leastAttractiveTextField]){
        
        NSMutableArray *coutriesArray = [NSMutableArray arrayWithObjects:@"Legal framework",@"Reputation",@"Business clusters",@"Geographic connectivity",@"Community",@"Others?",nil];
        [self showPopOverWithOptionsWithSourceArray:coutriesArray TextField:self.leastAttractiveTextField direction:UIPopoverArrowDirectionUp height:(int)[coutriesArray count]*44];
        return NO;
        
    }else if([textField isEqual:self.rankDIFCTextField]){
        
        NSMutableArray *coutriesArray = [NSMutableArray arrayWithObjects:@"Exceeds expectations",@"Meets expectations",@"Below expectation – Kindly elaborate",nil];
        [self showPopOverWithOptionsWithSourceArray:coutriesArray TextField:self.rankDIFCTextField direction:UIPopoverArrowDirectionUp height:(int)[coutriesArray count]*44];
        return NO;
        
    }else if([textField isEqual:self.comparableExperienceTextField]){
        
        NSMutableArray *coutriesArray = [NSMutableArray arrayWithObjects:@"London",@"New York",@"Singapore",@"Hong Kong",@"Luxemburg",nil];
        [self showPopOverWithOptionsWithSourceArray:coutriesArray TextField:self.comparableExperienceTextField direction:UIPopoverArrowDirectionUp height:(int)[coutriesArray count]*44];
        return NO;
        
    }else if([textField isEqual:self.interestedInTextField]){
        
        NSMutableArray *coutriesArray = [NSMutableArray arrayWithObjects:@"Corporate offices",@"Professional services",@"Banks",@"Islamic Finance",@"Insurance",@"Wealth management",@"Brokerage & capital markets",@"Retail and F&B",@"Technology & Innovation",@"Other – please specify",nil];
        [self showPopOverWithOptionsWithSourceArray:coutriesArray TextField:self.interestedInTextField direction:UIPopoverArrowDirectionDown height:(int)[coutriesArray count]*44];
        return NO;
    }else{
        [self startTimer];
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    [self startTimer];
    
    if([textField isEqual: self.emailAddressTextField] || [textField isEqual: self.otherTextField]){
     
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
        
    }else
        return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField isEqual:self.emailAddressTextField])
        [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [self startTimer];
    
    if([textField isEqual:self.emailAddressTextField])
        [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 350; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void)SelectedOTher:(int)T_A_G andSelectedText:(NSString *)selectedText {
    
    [self startTimer];
    
    switch (T_A_G) {
        case KnowAboutTextField:{
            if([[selectedText lowercaseString] isEqualToString:@"business referrals ­ please specify"])
                [self.knowAboutTextField setAccessibilityIdentifier:@"Business Referrals"];
            else
                [self.knowAboutTextField setAccessibilityIdentifier:@"Others"];
            break;
        }
        default:
            break;
    }

    [self.manualEntryView setTag:T_A_G];
//    sleep(0.5);
    
    [self.otherTextField setText:@""];
    self.manualEntryView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    self.manualEntryView.opaque = NO;
    
    [self showInView:self.view toView:self.manualEntryView animated:YES];
    [self.otherTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark - FILES/STORE AND SAVE

- (IBAction)didTapManualEntryButtons:(id)sender {
    
    [self startTimer];
    [self ResignAllResponders];
    
    UIButton *BTN = (UIButton *)sender;
    switch ([BTN tag]) {
            
        case 0:{
            
            NSString *enteredBArcode = [self.otherTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            switch (self.manualEntryView.tag) {
                case KnowAboutTextField:{
//                    [self.knowAboutTextField setText:enteredBArcode];
                    if([self.knowAboutTextField.accessibilityIdentifier isEqualToString:@"Business Referrals"])
                        [self.knowAboutTextField setText:[NSString stringWithFormat:@"%@(Business Referrals)",enteredBArcode]];
                    
                    if([self.knowAboutTextField.accessibilityIdentifier isEqualToString:@"Others"])
                        [self.knowAboutTextField setText:[NSString stringWithFormat:@"%@(Others)",enteredBArcode]];
                    
                    break;
                }
                case MostAttractiveTextField:
                    [self.mostAttractiveTextField setText:enteredBArcode];
                    break;
                case LeastAttractiveTextField:
                    [self.leastAttractiveTextField setText:enteredBArcode];
                    break;
                case RankDIFCTextField:
                    [self.rankDIFCTextField setText:enteredBArcode];
                    break;
                case ComparableExperienceTextField:
                    [self.comparableExperienceTextField setText:enteredBArcode];
                    break;
                case InterestedInTextField:
                    [self.interestedInTextField setText:enteredBArcode];
                    break;
                default:
                    break;
            }
            
            [self removeAnimate:self.manualEntryView];
            return;
        }
        case 1:{
            
            [self removeAnimate:self.manualEntryView];
            return;
        }
        default:
            break;
    }
}

- (IBAction)didTapBackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    return;
}

#pragma mark -
#pragma mark - SHOW/REMOVE ANIMATE

-(void)showAnimate:(UIView *)aView
{
    aView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    aView.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        aView.alpha = 1;
        aView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate:(UIView *)aView
{
    [UIView animateWithDuration:.25 animations:^{
        aView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        aView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view sendSubviewToBack:aView];
        }
    }];
}

- (void)showInView:(UIView *)aView toView:(UIView *)toView animated:(BOOL)animated
{
    [aView bringSubviewToFront:toView];
    if (animated) {
        [self showAnimate:toView];
    }
}


@end
