//
//  DatabaseModel.h
//  MyTableView
//
//  Created by macOS on 02/07/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseModel : NSObject {
    NSString *databasePath;
}

-(id)getSharedInstance;

-(BOOL)createDB;

-(BOOL) saveData:(int)pid username:(NSString*)username      phone:(NSString*)phone imageURL:(NSString*)imageURL description01: (NSString*)description01 description02: (NSString*)description02 description03: (NSString*)description03;

@end
