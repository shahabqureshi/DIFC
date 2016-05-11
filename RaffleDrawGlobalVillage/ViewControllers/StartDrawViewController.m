//
//  StartDrawViewController.m
//  RaffleDrawGlobalVillage
//
//  Created by Shahab Qureshi on 11/17/15.
//  Copyright (c) 2015 gtechme. All rights reserved.
//

#import "StartDrawViewController.h"

#import "SearchFilterViewController.h"
#import "RegisterViewController.h"

@interface StartDrawViewController ()

@end

@implementation StartDrawViewController

-(void) IncreaseBrightness {

//    [UIScreen mainScreen].brightness = 1.0;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.passwordTextField resignFirstResponder];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeAnimate:self.authenticationView];
    
    CGRect rect =  self.passwordTextField.frame;
    rect.size.height = rect.size.height + 30;
    [self.passwordTextField setFrame:rect];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapExportImageView)];
    [tapGesture setNumberOfTapsRequired:8];
    
    [self.tapToShowDataImageView addGestureRecognizer:tapGesture];
}

-(IBAction)didTapExportImageView {

    [self.passwordTextField setText:@""];
    [self.passwordTextField becomeFirstResponder];
    [self showInView:self.view toView:self.authenticationView animated:YES];
    return;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapLanguageButtons:(id)sender {
    
    sleep(0.5);
    RegisterViewController *REG_VC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:REG_VC animated:YES];
    return;
}

-(void) showAlertViewWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (IBAction)didTapProceedButton:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    switch ([btn tag]) {
        case 0:{
            
            if([self.passwordTextField.text isEqualToString:@"$DIFC&2016"]){
                
                [self.passwordTextField resignFirstResponder];
                
                [self.view sendSubviewToBack:self.authenticationView];
                
                SearchFilterViewController *searchVC = [[SearchFilterViewController alloc] initWithNibName:@"SearchFilterViewController" bundle:nil];
                [self.navigationController pushViewController:searchVC animated:YES];
                return;
                
            }else{
                [self showAlertViewWithMessage:@"Please enter a valid password."];
                return;
            }
            
            break;
        }
        case 1:{
            
            [self.passwordTextField resignFirstResponder];
            [self.passwordTextField setText:@""];
            [self removeAnimate:self.authenticationView];
            break;
        }
        default:
            break;
    }
}

- (IBAction)didTapBGButton:(id)sender {
    
    [self.passwordTextField resignFirstResponder];
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
