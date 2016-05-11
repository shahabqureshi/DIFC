//
//  ListPopOverController.h
//  EmiratesLNG
//
//  Created by Shahab on 11/9/13.
//  Copyright (c) 2013 GTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPopOverController : UITableViewController{
    id obj;
    NSMutableArray *dataArray;
    ListPopOverController *tbllist;
    UITextField *textField;

}
@property (nonatomic,retain)id obj;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)ListPopOverController *tbllist;
@property (nonatomic,retain)UITextField *textField;

- (id)initWithObject:(NSMutableArray *)array :(id)ob :(id)contolObj;
@end
