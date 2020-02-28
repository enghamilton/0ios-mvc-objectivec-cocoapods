//
//  UserModel.h
//  MyTableView
//
//  Created by macOS on 11/06/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserModelProtocol <NSObject>

- (void)itemsDownloaded:(NSDictionary *)items itemsDowmloaded2:(NSString *)items2;

@end

@interface UserModel : NSObject

@property (nonatomic, weak) id<UserModelProtocol> delegate;

- (void)downloadItems;

@end