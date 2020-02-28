//
//  ViewController.m
//  MyTableView
//
//  Created by macOS on 10/06/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
{
    NSArray *simpleArray;
    UserModel *_userModel;
    NSString *responseString3;
    NSMutableArray *arrayPid;
    NSMutableArray *arrayName;
    NSMutableArray *arrayPrice;
    NSMutableArray *arrayDescription;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    simpleArray = [NSArray arrayWithObjects:@"username 01", @"username 02", @"username 03", @"username 04", @"username 05", @"username 06", @"username 07", @"username 08", @"username 09", @"username 10", nil];
    arrayPid = [[NSMutableArray alloc] init];
    arrayName = [[NSMutableArray alloc] init];
    arrayPrice = [[NSMutableArray alloc] init];
    arrayDescription = [[NSMutableArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateTableView:)];
    
    _userModel = [[UserModel alloc] init];
    _userModel.delegate = self;
    
    NSString *stringArrayNameCounter = [NSString stringWithFormat:@"%d", [arrayName count]];
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"my app alert"                                                        message:stringArrayNameCounter                                                     delegate:nil                                              cancelButtonTitle:@"close"                                              otherButtonTitles:nil];
    [myAlertView show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [simpleArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier;
    UITableViewCell *cell;
    
    cellIdentifier = @"simpleTableCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [simpleArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"SegueForDetail" sender:self];
    /*
    if (indexPath.row == 2) {
        
    }
    */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //following lines needed only if you need to send some detail across to ContactViewController
    
    if ([segue.identifier isEqualToString:@"SegueForDetail"]) {
        //SecondViewController *secondlViewController = segue.destinationViewController;
    }
    

}

- (IBAction)updateTableView:(id)sender {
    [_userModel downloadItems];
    /*
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"my app alert"                                                        message:@"ok works !"                                                     delegate:nil                                              cancelButtonTitle:@"close"                                              otherButtonTitles:nil];
    [alertView show];
     */
}

-(void)itemsDownloaded:(NSDictionary *)items itemsDowmloaded2:(NSString *)items2 {
    // This delegate method will get called when the items are finished downloading when executed on press updateDatabase
    
    for (id objectsInJsonDict in items[@"products"]){
        responseString3 = [objectsInJsonDict objectForKey:@"name"];
        [arrayPid addObject:[objectsInJsonDict objectForKey:@"pid"]];
        [arrayName addObject:[objectsInJsonDict objectForKey:@"name"]];
        [arrayPrice addObject:[objectsInJsonDict objectForKey:@"price"]];
    }
    NSString *firstString1 = [arrayName objectAtIndex:0];
    NSString *secondString2 = [arrayName objectAtIndex:1];
    NSString *responseString2 = items[@"products"];
    NSString *str = [NSString stringWithFormat: @"%@ %@ %@", responseString2, firstString1, secondString2];

    responseString3 = [NSString stringWithFormat: @"%@", [items objectForKey:@"products"]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RESTful JSON"                                                        message: items2                                                    delegate:nil                                              cancelButtonTitle:@"close"                                              otherButtonTitles:nil];
    [alertView show];
    
    
}

@end
