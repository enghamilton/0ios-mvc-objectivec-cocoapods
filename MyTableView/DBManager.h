//
//  DBManager.h
//  MyTableView
//
//  Created by macOS on 03/07/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject {
    NSString *databasePath;
}

+(DBManager *)getSharedInstance;

-(BOOL)createDB;

-(BOOL)saveDataWithId:(int)pid username:(NSString*)username_DB      phone:(NSString*)phone_DB imageURL:(NSString*)imageURL_DB description01: (NSString*)description01_DB description02: (NSString*)description02_DB description03: (NSString*)description03_DB;

-(BOOL)anyMethod;

@end