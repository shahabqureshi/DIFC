//
//  DataLayer.h
//  EmiratesLNG
//
//  Created by Shahab on 11/9/13.
//  Copyright (c) 2013 GTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataLayer : NSObject

+ (BOOL ) AddNewApplicant:(NSString *)_querry;
+ (NSMutableArray *) getAllRecordsFromTable:(NSString *)_querry;

@end
