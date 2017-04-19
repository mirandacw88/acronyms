//
//  LongFormTableViewController.m
//  acronyms
//
//  Created by Cesar Miranda on 4/17/17.
//  Copyright © 2017 Cesar Miranda. All rights reserved.
//

#import "LongFormTableViewController.h"
#import "AcronymsModel.h"
#import "MBProgressHUD.h"

@interface LongFormTableViewController (){
    NSArray * dataArray;
    AcronymsModel * model;
    UISearchBar * search;
}
@end

#pragma mark - Strings

static NSString * const LONG_FORM_CELL_NIB_NAME     = @"LongFormTableViewCell";
static NSString * const OK_LABEL                    = @"Ok";
static NSString * const NO_SEARCH_RESULTS_LABEL     = @"No search results found.";
static NSString * const PLEASE_TRY_AGAIN_LABEL      = @"Please try another acronym.";
static NSString * const VIEW_TITLE                  = @"Acronym Search";

#pragma mark - Constants

static int NUMBER_OF_SECTION = 1;
static int TABLE_ROW_HEIGHT  = 20;

@implementation LongFormTableViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = VIEW_TITLE;
    
    // Set up search controller
    search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    search.delegate = self;
    // Set the search bar as the table header.
    self.tableView.tableHeaderView = search;
    
    model = [[AcronymsModel alloc] init];

}

#pragma mark - Private methods

-(void) showNoDataAlert{

    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:OK_LABEL
                               style:UIAlertActionStyleDefault
                               handler:nil];

    
    UIAlertController *alert =   [UIAlertController
                                  alertControllerWithTitle:NO_SEARCH_RESULTS_LABEL
                                  message:PLEASE_TRY_AGAIN_LABEL
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];


}

-(void) performSearchWithQuery:(NSString *)query{
    
    // Show Activity Indicator
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    //Execute the service call on the background head
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [model definitionsForAcronym:query withSuccess:^(id _Nonnull array) {
            if(array != nil){
                dataArray = array;
                // Executed the table relaod on the Main UI thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    if([dataArray count] > 0){
                        [[self tableView] reloadData];
                    }else{
                        [self showNoDataAlert];
                    }
                    //Hide Activity Indicator
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
                
            }
        }];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return NUMBER_OF_SECTION;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [dataArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return TABLE_ROW_HEIGHT;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LONG_FORM_CELL_NIB_NAME];
    AcronymsModel * modelData = dataArray[indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LONG_FORM_CELL_NIB_NAME];
    }
    
    // Configure the cell.
    cell.textLabel.text = [modelData fullDescription];
    
    return cell;
}

#pragma mark - Search Bar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    //Clear current data
    dataArray = nil;
    [[self tableView] reloadData];
    
    // Perform Search
    NSString * searchQuery = searchBar.text;
    [self performSearchWithQuery:searchQuery];
    
    // Close Keybaord
    [self.view endEditing:YES];

}

@end
