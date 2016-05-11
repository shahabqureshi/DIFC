//
//  InAppBrowserViewController.m
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/22/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import "InAppBrowserViewController.h"

@interface InAppBrowserViewController ()

@end

@implementation InAppBrowserViewController

@synthesize fileName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString *)documentsDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return documentsDirectoryPath;
}

-(void) showAlertViewWithMesage:(NSString *)_message {
    
    [[[UIAlertView alloc] initWithTitle:@"DIFC Survey" message:_message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    fileName = [fileName stringByReplacingOccurrencesOfString:@"txt" withString:@"csv"];
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingFormat:@"/%@",fileName];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:foofile]){
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:foofile]]];
    }else {
        [[[UIAlertView alloc] initWithTitle:@"DIFC Survey " message:@"Unable to open file. May be corrupted or file not in correct format." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
