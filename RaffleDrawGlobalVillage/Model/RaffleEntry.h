//
//  RaffleEntry.h
//  RaffleDrawGlobalVillage
//
//  Created by Shahab Qureshi on 11/17/15.
//  Copyright (c) 2015 gtechme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RaffleEntry : NSObject

//CREATE TABLE "CustomerSurvey" ("surveyID" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , "knowAboutDIFC" VARCHAR, "mostAttractive" VARCHAR, "leastAttractive" VARCHAR, "rankDIFC" VARCHAR, "comparableExperienceToDIFC" VARCHAR, "interestedInService" VARCHAR, "emailAddress" VARCHAR, "UDID" VARCHAR, "DateTime" VARCHAR, "deviceName" VARCHAR)

@property(nonatomic, retain) NSString *surveyID;
@property(nonatomic, retain) NSString *knowAboutDIFC;
@property(nonatomic, retain) NSString *mostAttractive;
@property(nonatomic, retain) NSString *leastAttractive;
@property(nonatomic, retain) NSString *rankDIFC;
@property(nonatomic, retain) NSString *comparableExperienceToDIFC;
@property(nonatomic, retain) NSString *interestedInService;
@property(nonatomic, retain) NSString *emailAddress;

@property(nonatomic, retain) NSString *UDID;
@property(nonatomic, retain) NSString *DateTime;
@property(nonatomic, retain) NSString *deviceName;

@end
