//
//  FinalViewController.m
//  RaffleDrawGlobalVillage
//
//  Created by Shahab Qureshi on 11/18/15.
//  Copyright (c) 2015 gtechme. All rights reserved.
//

#import "FinalViewController.h"

@interface FinalViewController ()

@end

@implementation FinalViewController

-(void)NoActivityGoHome {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [TIMER invalidate];
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
        
    TIMER = [NSTimer scheduledTimerWithTimeInterval:1*60
                                             target:self
                                           selector:@selector(NoActivityGoHome)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapHomeButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    return;
}

@end
