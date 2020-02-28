//
//  DatabaseModel.m
//  MyTableView
//
//  Created by macOS on 02/07/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "DatabaseModel.h"

static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;


@interface DatabaseModel()

-(id)getSharedInstance;

-(BOOL)createDB;

-(BOOL) saveData:(int)pid username:(NSString*)username      phone:(NSString*)phone imageURL:(NSString*)imageURL description01: (NSString*)description01 description02: (NSString*)description02 description03: (NSString*)description03;

@end

@implementation DatabaseModel

-(id)getSharedInstance {
    static id sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[DatabaseModel alloc] init];
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

- (BOOL) saveData:(int)pid username:(NSString*)username      phone:(NSString*)phone imageURL:(NSString*)imageURL description01: (NSString*)description01 description02: (NSString*)description02 description03: (NSString*)description03 {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, & database) == SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into gpapp_table (pid integer primary key, username text, phone text, imageURL text, description01 text, description02 text, description03 text) values pid, username, phone, imageURL, description01, description02, description03"];
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

@end
