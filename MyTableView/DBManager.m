//
//  DBManager.m
//  MyTableView
//
//  Created by macOS on 03/07/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
/*
+(DBManager *)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}
*/
+(DBManager *)getSharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[DBManager alloc] init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB {
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"gpapp_database.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists gpapp_table (pid integer            primary key, username text, phone text, imageURL text, description01 text, description02 text, description03 text)";
            
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        } else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL)saveDataWithId:(int)pid username:(NSString*)username_DB      phone:(NSString*)phone_DB imageURL:(NSString*)imageURL_DB description01: (NSString*)description01_DB description02: (NSString*)description02_DB description03: (NSString*)description03_DB {
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
        
        /*
        NSString *insertSQL = [NSString stringWithFormat:@"insert into gpapp_table (pid integer primary key, username text, phone text, imageURL text, description01 text, description02 text, description03 text) values pid, username_DB, phone_DB, imageURL_DB, description01_DB, description02_DB, description03_DB"];
        */
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO gpapp_table (pid, username, phone, imageURL, description01, description02, description03) values (\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", pid, username_DB, phone_DB, imageURL_DB, description01_DB, description02_DB, description03_DB ];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

-(BOOL)anyMethod{
    return YES;
}
@end