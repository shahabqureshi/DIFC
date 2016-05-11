//
//  DataLayer.m
//  EmiratesLNG
//
//  Created by Shahab on 11/9/13.
//  Copyright (c) 2013 GTech. All rights reserved.
//

#import "DataLayer.h"
#import "AppDelegate.h"
#import "RaffleEntry.h"

@implementation DataLayer

+ (BOOL ) AddNewApplicant:(NSString *)_querry {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *userDB;
    BOOL isInsertionSuccessfull = NO;
    
    NSString *databasePath = [appDelegate getDBPath];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &userDB) == SQLITE_OK)
    {        
        const char *insert_stmt = [_querry UTF8String];
        
        sqlite3_prepare_v2(userDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            isInsertionSuccessfull = YES;
        } else {
            isInsertionSuccessfull = NO;
        }
        sqlite3_finalize(statement);
        sqlite3_close(userDB);
    }
    
    return isInsertionSuccessfull;
}

+ (NSMutableArray *) getAllRecordsFromTable:(NSString *)_querry {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *userDB;
    
    NSString *databasePath = [appDelegate getDBPath];
    const char *dbpath = [databasePath UTF8String];
    
    sqlite3_stmt *statement;
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    
    if (sqlite3_open(dbpath, &userDB) == SQLITE_OK) {
        
        const char *query_stmt = [_querry UTF8String];
        
        if (sqlite3_prepare_v2(userDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                int columCount = sqlite3_column_count(statement);
                
                RaffleEntry *regObject = [[RaffleEntry alloc] init];
                
                for(int i=0; i<columCount; i++){
                    
                    NSString *columnName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(statement, i)];
                    NSString *columValue = [[NSString alloc]initWithCString:(const char *) sqlite3_column_text(statement,i) encoding:NSUTF8StringEncoding];
                    
                    if([columnName isEqualToString:@"surveyID"])
                        regObject.surveyID = columValue;
                    
                    if([columnName isEqualToString:@"knowAboutDIFC"])
                        regObject.knowAboutDIFC = columValue;
                    
                    if([columnName isEqualToString:@"mostAttractive"])
                        regObject.mostAttractive = columValue;
                    
                    if([columnName isEqualToString:@"leastAttractive"])
                        regObject.leastAttractive = columValue;
                    
                    if([columnName isEqualToString:@"rankDIFC"])
                        regObject.rankDIFC = columValue;
                    
                    if([columnName isEqualToString:@"comparableExperienceToDIFC"])
                        regObject.comparableExperienceToDIFC = columValue;
                    
                    if([columnName isEqualToString:@"interestedInService"])
                        regObject.interestedInService = columValue;
                    
                    if([columnName isEqualToString:@"emailAddress"])
                        regObject.emailAddress = columValue;
                    
                    if([columnName isEqualToString:@"deviceName"])
                        regObject.deviceName = columValue;
                    
                    if([columnName isEqualToString:@"UDID"])
                        regObject.UDID = columValue;
                    
                    if([columnName isEqualToString:@"DateTime"])
                        regObject.DateTime = [NSString stringWithFormat:@"%@",columValue];
                    
                }
                [dataArray addObject:regObject];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(userDB);
    }
    return dataArray;

}

@end
