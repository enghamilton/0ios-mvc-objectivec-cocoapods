//
//  ViewController.h
//  MyTableView
//
//  Created by macOS on 10/06/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UserModelProtocol>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateTableView;

-(IBAction) updateTableView:(id)sender;

@end

