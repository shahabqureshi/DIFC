//
//  InAppBrowserViewController.h
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/22/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InAppBrowserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) NSString *fileName;

- (IBAction)didTapBackButton:(id)sender;

@end
