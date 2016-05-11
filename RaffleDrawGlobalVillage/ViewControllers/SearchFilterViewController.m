//
//  SearchFilterViewController.m
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/21/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import "SearchFilterViewController.h"
#import "UserCustomCell.h"
#import "DataLayer.h"
#import "RaffleEntry.h"
#import "ViewExportFilesViewController.h"


@interface SearchFilterViewController ()

@end

@implementation SearchFilterViewController

@synthesize popoverController;
@synthesize datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.searchDisplayController.searchResultsTableView setHidden:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [self.selectDateView setHidden:NO];
    
    [self.toDateTextField setText:[self getDateTimeInFormat:[NSDate date]]];

    NSDate *DDD = [self addDaysToDate:[NSDate date] addDays:-7];
    [self.fromDateTextField setText:[self getDateTimeInFormat:DDD]];
    
    [self.exportButton setEnabled:NO];
}

-(IBAction) showResultPopOver:(id)sender {
    
    UIButton *btn = (UIButton *)sender;

    if([btn tag] == 101){
        
        [self.fromDateTextField setText:[self getDateTimeInFormat:datePicker.date]];
        [self.toDateTextField setText:@""];
    }
    
    if([btn tag] == 202)
        [self.toDateTextField setText:[self getDateTimeInFormat:datePicker.date]];
    
    [popoverController dismissPopoverAnimated:YES];
}

-(NSDate *)addDaysToDate:(NSDate *)currentDate addDays:(int)days {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:days];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    return newDate;
}


-(NSDate *) getDateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

-(NSString *)getDateTimeInFormat:(NSDate *)selectedDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/Y"];
    NSString *dateString = [dateFormatter stringFromDate:selectedDate];
    return dateString;
}

-(NSString *)getDateTimeInFormat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/Y hh/mm/ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

-(void) cancelPopOver {

    [popoverController dismissPopoverAnimated:YES];
}

-(void) showDatePickerInPopOverOnTextField:(UITextField *)txtField {
    
    UIViewController* popoverContent = [[UIViewController alloc] init]; //ViewController
    
    UIView *popoverView = [[UIView alloc] init];   //view
    popoverView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnOK = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOK setTitle:@"Select" forState:UIControlStateNormal];
    [btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOK setBackgroundImage:[UIImage imageNamed:@"bluebutton.png"] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(showResultPopOver:) forControlEvents:UIControlEventTouchUpInside];
    [btnOK setFrame:CGRectMake(10, 10, 100, 35)];
    [btnOK setTag:[txtField tag]];
    [popoverView addSubview:btnOK];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[UIImage imageNamed:@"redbutton.png"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(cancelPopOver) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setFrame:CGRectMake(210, 10, 100, 35)];
    [popoverView addSubview:btnCancel];
    
    datePicker=[[UIDatePicker alloc]init];//Date picker
    datePicker.frame=CGRectMake(0,54,320, 226);
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setTag:[txtField tag]];
//    [datePicker addTarget:self action:@selector(result) forControlEvents:UIControlEventValueChanged];
    
    if (txtField == self.toDateTextField){
        
        NSArray *arr = [self.fromDateTextField.text componentsSeparatedByString:@"/"];
        NSString *formattedDateString = [NSString stringWithFormat:@"%@-%@-%@",[arr objectAtIndex:2],[arr objectAtIndex:1],[arr objectAtIndex:0]];
        NSDate *startDate = [self getDateFromString:formattedDateString];
        [datePicker setMinimumDate:startDate];
        [datePicker setMaximumDate:[self addDaysToDate:startDate addDays:30]];
    }
    
    [datePicker setBackgroundColor:[UIColor clearColor]];
    [popoverView addSubview:datePicker];
    
    popoverContent.view = popoverView;
    popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    popoverController.delegate=self;
    
    [popoverController setPopoverContentSize:CGSizeMake(320, 274) animated:NO];
    [popoverController presentPopoverFromRect:txtField.frame inView:self.selectDateView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];//tempButton.frame where you need you can put that frame
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - UI EVENTS

- (IBAction)didTapFilterButton:(id)sender {
    
    if([self.fromDateTextField.text length] == 0 || [self.toDateTextField.text length] == 0){
        [self showAlertViewWithMesage:@"Please choose date range first."];
        return;
    }
    
    registeredContacts = [[NSArray alloc] init];
    
    NSString *strFromDate = self.fromDateTextField.text;
    NSArray *fromArray = [strFromDate componentsSeparatedByString:@"/"];
    if([fromArray count]==3)
        strFromDate = [NSString stringWithFormat:@"%@-%@-%@",[fromArray objectAtIndex:2],[fromArray objectAtIndex:1],[fromArray objectAtIndex:0]];
    
    NSString *strToDate = self.toDateTextField.text;
    NSArray *toArray = [strToDate componentsSeparatedByString:@"/"];
    if([toArray count]==3)
        strToDate = [NSString stringWithFormat:@"%@-%@-%@",[toArray objectAtIndex:2],[toArray objectAtIndex:1],[toArray objectAtIndex:0]];
    
    registeredContacts = [DataLayer getAllRecordsFromTable:[NSString stringWithFormat:@"SELECT * FROM CustomerSurvey WHERE DATE(substr(DateTime,7,4) ||'-' ||substr(DateTime,4,2) ||'-' ||substr(DateTime,1,2)) BETWEEN DATE('%@') AND DATE('%@')",strFromDate,strToDate]];
    
    if([registeredContacts count] == 0){
        
        [self.exportButton setEnabled:YES];
        [self showAlertViewWithMesage:@"NO data found against these dates."];
        [self.searchTableView reloadData];
        return;
    }else{
        [self.searchTableView reloadData];
        [self.exportButton setEnabled:YES];
    }
}

- (IBAction)didTapExportButton:(id)sender {


    UIButton *btn = (UIButton *)sender;

    switch ([btn tag]) {
            
        case 0:{
            
            if([registeredContacts count] == 0){
                [self showAlertViewWithMesage:@"No data found to export in files."];
                return;
            }
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
            NSString *documentsDir = [paths objectAtIndex:0];
            NSString *strDate = [self getDateTimeInFormat];
            strDate = [strDate stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
            
            NSString *toDateString = [self.toDateTextField.text stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
            NSString *fromDateString = [self.fromDateTextField.text stringByReplacingOccurrencesOfString:@"/" withString:@"_"];

            NSString *textDocumentRoot = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"DIFC_Survey %@ to %@.txt",fromDateString,toDateString]];
            NSString *csvDocumentRoot = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"DIFC_Survey %@ to %@.csv",fromDateString,toDateString]];
            
            NSString *temp;
            temp = [NSString stringWithFormat:@" Survey ID,How do you know about DIFC?, What is most attractive about DIFC?, What is least attractive about DIFC?,How would you rank DIFC compared to other international financial centres?,Which international financial centre offers a comparable experience to DIFC ?,What particular services are you interested in? Please specify,If you would like to receive news from the DIFC - kindly share your email address,Device ID,Device Name, Created Date \n "];
            
            for(int i = 0; i < [registeredContacts count]; i++){
                
                RaffleEntry *reg = (RaffleEntry *)[registeredContacts objectAtIndex:i];
                
                NSString *deviceName = reg.deviceName;
                NSString *UDID = reg.UDID;
                deviceName = [deviceName stringByReplacingOccurrencesOfString:@"[]"
                                                                   withString:@"'"];
                if(i == [registeredContacts count]-1)
                    temp = [temp stringByAppendingFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",reg.surveyID,reg.knowAboutDIFC,reg.mostAttractive,reg.leastAttractive,reg.rankDIFC,reg.comparableExperienceToDIFC,reg.interestedInService,reg.emailAddress,UDID,deviceName,reg.DateTime];
                else
                    temp = [temp stringByAppendingFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ \n",reg.surveyID,reg.knowAboutDIFC,reg.mostAttractive,reg.leastAttractive,reg.rankDIFC,reg.comparableExperienceToDIFC,reg.interestedInService,reg.emailAddress,UDID,deviceName,reg.DateTime];
            }
            
            [temp stringByReplacingOccurrencesOfString:@"'" withString:@"-"];
            [temp stringByReplacingOccurrencesOfString:@"," withString:@"-"];
            [temp stringByReplacingOccurrencesOfString:@"\''" withString:@"|"];
            [temp stringByReplacingOccurrencesOfString:@"\"" withString:@"|"];

//            UTF-16LE
            [temp writeToFile:textDocumentRoot atomically:YES encoding:NSUTF8StringEncoding error:NULL];
            [temp writeToFile:csvDocumentRoot atomically:YES encoding:NSUTF8StringEncoding error:NULL];
            
            
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"DIFC Survey"
                                                              message:@"Data has been saved in excel file, you can export via itunes."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [alertView show];
            break;
        }
            
        case 1:{
            
            ViewExportFilesViewController *exportVC = [[ViewExportFilesViewController alloc] initWithNibName:@"ViewExportFilesViewController" bundle:nil];
            [self.navigationController pushViewController:exportVC animated:YES];
            break;
        }
        default:
            break;
    }

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)didTapBackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UI

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
 
    if (textField == self.toDateTextField){
        if([self.fromDateTextField.text length] == 0){
            
            [self showAlertViewWithMesage:@"Please choose start date first"];
            return NO;
        }
    }
    
    [self showDatePickerInPopOverOnTextField:textField];
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

-(void) showAlertViewWithMesage:(NSString *)_message {
    
    [[[UIAlertView alloc] initWithTitle:@"DIFC Survey" message:_message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

#pragma mark -
#pragma mark - UITABLE VIEW DELEGATE METHODS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [registeredContacts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 187;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 10)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 10)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"UserCustomCell_%ld_%ld",(long)indexPath.row,(long)indexPath.section];
    
    [tableView setScrollEnabled:YES];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    UserCustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (customCell == nil) {
        
        NSArray *xibViews = [[NSBundle mainBundle] loadNibNamed:@"UserCustomCell" owner:nil options:nil];
        customCell = (UserCustomCell *)[xibViews  objectAtIndex:0];
    }
    
    RaffleEntry *mothRommObj = [registeredContacts objectAtIndex:indexPath.row];
    [customCell.knowAboutLabel setText:mothRommObj.knowAboutDIFC];
    [customCell.mostAttractiveLabel setText:mothRommObj.mostAttractive];
    [customCell.rankLabel setText:mothRommObj.rankDIFC];
    [customCell.interestedInLabel setText:mothRommObj.interestedInService];
    [customCell.emailAddressLabel setText:mothRommObj.emailAddress];
    [customCell.createdDate setText:mothRommObj.DateTime];
    
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    MotherRoom *mothRommObj = [registeredContacts objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
