//
//  ListPopOverController.m
//  EmiratesLNG
//
//  Created by Shahab on 11/9/13.
//  Copyright (c) 2013 GTech. All rights reserved.
//

#import "ListPopOverController.h"
#import "RegisterViewController.h"

@interface ListPopOverController ()

@end

@implementation ListPopOverController

@synthesize dataArray,tbllist,obj,textField;


- (id)initWithObject:(NSMutableArray *)array :(id)ob :(id)contolObj
{
    self = [super initWithNibName:@"ListPopOverController" bundle:nil];
    if (self) {
        dataArray=[[NSMutableArray alloc]init];
        dataArray=array;
        self.obj=ob;
        self.textField=(UITextField*)contolObj;
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text=[dataArray objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:4.0/255.0 green:61.0/255.0 blue:90.0/255.0 alpha:1.0]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [((RegisterViewController*)obj).popOverController dismissPopoverAnimated:YES];

    NSString *SelectedString = [dataArray objectAtIndex:indexPath.row];
    
    if ([obj isKindOfClass:[RegisterViewController class]]){

        if ([self.textField isEqual:((RegisterViewController*)obj).knowAboutTextField]){
//            ((RegisterViewController*)obj).knowAboutTextField.text=[dataArray objectAtIndex:indexPath.row];
            
            if ([[SelectedString lowercaseString] rangeOfString:@"other"].location == NSNotFound){
            
                if ([[SelectedString lowercaseString] rangeOfString:@"please specify"].location == NSNotFound){
                    ((RegisterViewController*)obj).knowAboutTextField.text = SelectedString;
                }else{
                    [((RegisterViewController*)obj) SelectedOTher:(int)[((RegisterViewController*)obj).knowAboutTextField tag] andSelectedText:SelectedString];
                }
            }
            else
                [((RegisterViewController*)obj) SelectedOTher:(int)[((RegisterViewController*)obj).knowAboutTextField tag] andSelectedText:SelectedString];
        }

        if ([self.textField isEqual:((RegisterViewController*)obj).mostAttractiveTextField]){
            
            if ([[SelectedString lowercaseString] rangeOfString:@"other"].location == NSNotFound)
                ((RegisterViewController*)obj).mostAttractiveTextField.text = SelectedString;
            else
                [((RegisterViewController*)obj) SelectedOTher:(int)[((RegisterViewController*)obj).mostAttractiveTextField tag] andSelectedText:SelectedString];
        }
        
        if ([self.textField isEqual:((RegisterViewController*)obj).leastAttractiveTextField]){
//            ((RegisterViewController*)obj).leastAttractiveTextField.text=[dataArray objectAtIndex:indexPath.row];
            if ([[SelectedString lowercaseString] rangeOfString:@"other"].location == NSNotFound)
                ((RegisterViewController*)obj).leastAttractiveTextField.text = SelectedString;
            else
                [((RegisterViewController*)obj) SelectedOTher:(int)[((RegisterViewController*)obj).leastAttractiveTextField tag] andSelectedText:SelectedString];
        }
        
        if ([self.textField isEqual:((RegisterViewController*)obj).rankDIFCTextField]){
//            ((RegisterViewController*)obj).rankDIFCTextField.text=[dataArray objectAtIndex:indexPath.row];
            
            if ([[SelectedString lowercaseString] rangeOfString:@"kindly elaborate"].location == NSNotFound)
                ((RegisterViewController*)obj).rankDIFCTextField.text = SelectedString;
            else
                [((RegisterViewController*)obj) SelectedOTher:(int)[((RegisterViewController*)obj).rankDIFCTextField tag] andSelectedText:SelectedString];
        }
        
        if ([self.textField isEqual:((RegisterViewController*)obj).comparableExperienceTextField]){
//            ((RegisterViewController*)obj).comparableExperienceTextField.text=[dataArray objectAtIndex:indexPath.row];
            if ([[SelectedString lowercaseString] rangeOfString:@"other"].location == NSNotFound)
                ((RegisterViewController*)obj).comparableExperienceTextField.text = SelectedString;
            else
                [((RegisterViewController*)obj) SelectedOTher:(int)[((RegisterViewController*)obj).comparableExperienceTextField tag] andSelectedText:SelectedString];
        }
        
        if ([self.textField isEqual:((RegisterViewController*)obj).interestedInTextField]){
//            ((RegisterViewController*)obj).interestedInTextField.text=[dataArray objectAtIndex:indexPath.row];
            if ([[SelectedString lowercaseString] rangeOfString:@"other"].location == NSNotFound)
                ((RegisterViewController*)obj).interestedInTextField.text = SelectedString;
            else
                [((RegisterViewController*)obj) SelectedOTher:(int)[((RegisterViewController*)obj).interestedInTextField tag] andSelectedText:SelectedString];
        }
    }
}

@end
