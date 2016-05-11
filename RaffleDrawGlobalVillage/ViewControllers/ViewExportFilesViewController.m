//
//  ViewExportFilesViewController.m
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/22/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import "ViewExportFilesViewController.h"
#import "FilesCustomCell.h"
#import "InAppBrowserViewController.h"

#import "AppDelegate.h"

@interface ViewExportFilesViewController ()

@end

@implementation ViewExportFilesViewController

@synthesize filesViewTableView;

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    filesArray = [[NSMutableArray alloc] init];
    chosenFiles = [[NSMutableArray alloc] init];
    
    NSString *extension = @"txt";
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:NULL];
    filesArray = [NSMutableArray arrayWithCapacity: [contents count]];
    
    NSString *filename;
    for (filename in contents)
        if ([[filename pathExtension] isEqualToString:extension])
            [filesArray addObject: filename];
    
    self.filesViewTableView.separatorColor = [UIColor darkGrayColor];
    
    [self.spinner setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(IBAction)didTapDeleteButton:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingFormat:@"/%@",[filesArray objectAtIndex:[btn tag]]];
    BOOL isFileRemoved = [[NSFileManager defaultManager] removeItemAtPath:foofile error:nil];
    
    if(isFileRemoved){
        
        [filesArray removeObjectAtIndex:[btn tag]];
        [self.filesViewTableView reloadData];
        [chosenFiles removeAllObjects];
        
    }else
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Error removing file." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

-(IBAction)didTapChooseButton:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if([btn.titleLabel.text isEqualToString:@"Choose"]){
        
        [chosenFiles addObject:[filesArray objectAtIndex:[btn tag]]];
        [btn setTitle:@"Choosen" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bluebutton.png"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        return;
    }
    
    if([btn.titleLabel.text isEqualToString:@"Choosen"]){
        
        [chosenFiles removeObject:[filesArray objectAtIndex:[btn tag]]];
        [btn setTitle:@"Choose" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"redbutton.png"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        return;
    }
}

#pragma mark -
#pragma mark - UITABLE VIEW DELEGATE METHODS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filesArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 59;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 10)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"FilesCustomCell";
    [tableView setScrollEnabled:YES];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    FilesCustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (customCell == nil) {
        
        NSArray *xibViews = [[NSBundle mainBundle] loadNibNamed:@"FilesCustomCell" owner:nil options:nil];
        customCell = (FilesCustomCell *)[xibViews  objectAtIndex:0];
        
    }
    // Display recipe in the table cell
    [customCell.fileNameLabel setText:[filesArray objectAtIndex:indexPath.row]];
    
    [customCell.deleteButton setTag:indexPath.row];
    [customCell.chooseButton setTag:indexPath.row];
    
    [customCell.deleteButton addTarget:self action:@selector(didTapDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [customCell.chooseButton addTarget:self action:@selector(didTapChooseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InAppBrowserViewController *inAppVC = [[InAppBrowserViewController alloc] initWithNibName:@"InAppBrowserViewController" bundle:nil];
    inAppVC.fileName = [filesArray objectAtIndex:indexPath.row];
    [self presentViewController:inAppVC animated:YES completion:nil];
}

-(void) showAlertViewWithMesage:(NSString *)_message {
    
    [[[UIAlertView alloc] initWithTitle:@"DIFC Survey " message:_message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

-(NSData *)returnFileData:(NSString *)_imageName {
    
    if(_imageName.length<3)
        return [NSData data];
    
    NSData *imgData;
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *treeImagePath = [NSString stringWithFormat:@"%@/%@",docDir,_imageName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:treeImagePath])
        imgData = [NSData dataWithContentsOfFile:treeImagePath];
    
    return imgData;
}

- (IBAction)didTapFilesExportButtons:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        if([chosenFiles count]>=1){
            
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            
            NSString *subject = @"Registered Users : DIFC Survey ";
            [picker setSubject:subject];
            NSString *emailBody = @"";
            for(NSString *fileNameString in chosenFiles){
                
                NSString *file_name_CSV = [fileNameString stringByReplacingOccurrencesOfString:@".txt" withString:@".csv"];
                NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString* foofile = [documentsPath stringByAppendingFormat:@"/%@",file_name_CSV];
                [picker addAttachmentData:[NSData dataWithContentsOfFile:foofile] mimeType:@"text/csv" fileName:file_name_CSV];
            }
            [picker setMessageBody:emailBody isHTML:NO];
            [self presentViewController:picker animated:YES completion:nil];
            return;
            
        }else{
            
            [self showAlertViewWithMesage:@"No file has been choosen."];
            return;
        }
        
    }else{
        
        [self showAlertViewWithMesage:@"Sorry your device is not configured to send emails."];
        return;
    }
}

- (IBAction)didTapBackButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Email & Text composer delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error{
    
    NSString *message=@"";
    
    switch (result) {
            
        case MFMailComposeResultCancelled:
            message = @"Message Canceled";
            break;
        case MFMailComposeResultSaved:
            message = @"Message Saved";
            break;
        case MFMailComposeResultSent:
            message = @"Message Sent";
            break;
        case MFMailComposeResultFailed:
            message = @"Message Failed";
            break;
        default:
            message = @"Message Not Sent";
            break;
    }
    [self showAlertViewWithMesage:message];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [chosenFiles removeAllObjects];
    [self.filesViewTableView reloadData];
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
