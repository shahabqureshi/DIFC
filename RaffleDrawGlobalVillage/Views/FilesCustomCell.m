//
//  FilesCustomCell.m
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/22/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import "FilesCustomCell.h"

@implementation FilesCustomCell

@synthesize fileNameLabel, deleteButton, chooseButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
}

@end
