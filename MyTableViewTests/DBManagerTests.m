//
//  DBManagerTests.m
//  MyTableView
//
//  Created by macOS on 03/07/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DBManager.h"

@interface DBManager (Test)

@property(nonatomic,strong) NSString *databasePath;

+(DBManager *)getSharedInstance;

-(BOOL)createDB;

-(BOOL) saveDataWithId:(int)pid username:(NSString*)username      phone:(NSString*)phone imageURL:(NSString*)imageURL description01: (NSString*)description01 description02: (NSString*)description02 description03: (NSString*)description03;

@end

@interface DBManagerTests : XCTestCase

@end

@implementation DBManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //[[DBManager getSharedInstance] createDB];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int pID = 1;
    NSString *dbName = [NSString stringWithFormat:@"user01"];
    NSString *dbPhone = [NSString stringWithFormat:@"900001234"];
    NSString *dbImageURL = [NSString stringWithFormat:@"http://www.site.com.br/user01/imageFolder/image01.jpg"];
    NSString *dbDescription01 = [NSString stringWithFormat:@"description 1"];
    NSString *dbDescription02 = [NSString stringWithFormat:@"description 2"];
    NSString *dbDescription03 = [NSString stringWithFormat:@"description 3"];
    
    BOOL unitTestDBmanager = [[DBManager getSharedInstance] saveDataWithId:pID username:dbName phone:dbPhone imageURL:dbImageURL description01:dbDescription01 description02:dbDescription02 description03:dbDescription03];
    
    XCTAssertTrue(unitTestDBmanager);
}

-(void)testSingleton {
    XCTAssertTrue([DBManager getSharedInstance].anyMethod);
}

-(void)testCreateDb{
    BOOL unitTestCreateDb = [DBManager getSharedInstance].createDB;
    XCTAssertTrue(unitTestCreateDb);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
