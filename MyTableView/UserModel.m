//
//  UserModel.m
//  MyTableView
//
//  Created by macOS on 11/06/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

{
    NSMutableData *_downloadedData;
    //NSDictionary *_jsonElement;
    //NSString *responseString3;
    NSMutableArray *arrayJsonPid;
    NSMutableArray *arrayJsonName;
    NSMutableArray *arrayJsonPrice;
}

- (void)downloadItems {
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"https://pizzaria2.000webhostapp.com/android_connect/get_all_products.php"];
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    //https: //stackoverflow.com/questions/32647138/nsurlconnection-initwithrequest-is-deprecated
}

#pragma mark NSURLConnectionDataProtocol Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *responseString = [[NSString alloc] initWithData:_downloadedData encoding:NSUTF8StringEncoding];
    NSArray *tmpArrayResponseString = [responseString componentsSeparatedByString:@"<html>"];
    responseString = [tmpArrayResponseString objectAtIndex:0];
    
    NSData *tmpData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:tmpData options:NSJSONReadingAllowFragments error:&error];
    //NSString *responseString2 = jsonDict[@"products"];
    /*
    for (id objectsInJsonDict in jsonDict[@"products"]){
        responseString3 = [objectsInJsonDict objectForKey:@"name"];
        //[arrayJsonName addObject:[objectsInJsonDict objectForKey:@"name"]];
    }
    */
    if (self.delegate) {
        [self.delegate itemsDownloaded:jsonDict itemsDowmloaded2:responseString];
    }
}

@end
