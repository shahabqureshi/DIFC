//
//  ViewExportFilesViewController.h
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/22/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ViewExportFilesViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>{
    
    NSMutableArray *filesArray;
    NSMutableArray *chosenFiles;
}

@property (weak, nonatomic) IBOutlet UITableView *filesViewTableView;

- (IBAction)didTapFilesExportButtons:(id)sender;
- (IBAction)didTapBackButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end
