//
//  StartDrawViewController.h
//  RaffleDrawGlobalVillage
//
//  Created by Shahab Qureshi on 11/17/15.
//  Copyright (c) 2015 gtechme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartDrawViewController : UIViewController

- (IBAction)didTapLanguageButtons:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *tapToShowDataImageView;

@property (weak, nonatomic) IBOutlet UIView *authenticationView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)didTapProceedButton:(id)sender;

@end
