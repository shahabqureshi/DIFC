//
//  UserCustomCell.m
//  PresidantsCupUAEFA
//
//  Created by Shahab Qureshi on 4/21/14.
//  Copyright (c) 2014 presidantscupuaefa. All rights reserved.
//

#import "UserCustomCell.h"

@implementation UserCustomCell

@synthesize knowAboutLabel, mostAttractiveLabel, rankLabel, emailAddressLabel, interestedInLabel, createdDate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
}

@end
