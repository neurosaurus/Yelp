//
//  FiltersViewController.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "FiltersViewController.h"
#import "SeeAllCell.h"
#import "SegmentedPriceCell.h"
#import "Filters.h"

@interface FiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *categories;
@property (nonatomic, assign) BOOL featuresExpanded;
@property (nonatomic, assign) BOOL sortByExpanded;
@property (nonatomic, assign) BOOL distanceExpanded;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.categories = [NSMutableArray arrayWithObjects:@{
                                                             @"name":@"Price",
                                                             @"type":@"segmented",
                                                             @"list":@[@"$",@"$$",@"$$$",@"$$$$"]
                                                             },
                           @{
                             @"name":@"Most Popular",
                             @"type":@"switches",
                             @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
                             },
                           @{
                             @"name":@"Distance",
                             @"type":@"expandable",
                             @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"]
                             },
                           @{
                             @"name":@"Sort By",
                             @"type":@"expandable",
                             @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"]
                             },
                           @{
                             @"name":@"General Features",
                             @"type":@"expandable",
                             @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"]
                             },nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SegmentedPriceCell" bundle:nil] forCellReuseIdentifier:@"SegmentedPriceCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SeeAllCell" bundle:nil] forCellReuseIdentifier:@"SeeAllCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SeeAllCell" bundle:nil] forCellReuseIdentifier:@"FilterViewCell"];
    UINavigationBar *header = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,45)];
    
    UINavigationItem *buttonHold = [[UINavigationItem alloc]initWithTitle:@"Filter"];
    
    UIBarButtonItem *barBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancel:)];
    UIBarButtonItem *barSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveFilter:)];
    
    [buttonHold setLeftBarButtonItem:barBackButton];
    [buttonHold setRightBarButtonItem:barSaveButton];
    
    NSArray *barItemArray = [[NSArray alloc]initWithObjects:buttonHold,nil];
    
    [header setItems:barItemArray];
    
    [self.tableView setTableHeaderView:header];
}

#pragma mark - Buttons
- (void)onCancel:(UIBarButtonItem *)button
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    return;
}

- (void)saveFilter:(UIBarButtonItem *)button
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    
    [self filterSettings:filters];
    [self dismissViewControllerAnimated:YES completion:^{}];
    return;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.categories.count;
}

#pragma mark - Filter Delegate

- (void)filterSettings:(NSMutableDictionary *)data
{
    if ([self.delegate respondsToSelector:@selector(filterSettings:)])
    {
        [self.delegate filterSettings:data];
    }
}

- (void)sender:(FilterViewCell *)sender didChangeValue:(BOOL)value
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view methods -- Datasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Price";
        case 1:
            return @"Most Popular";
        case 2:
            return @"Distance";
        case 3:
            return @"Sort By";
        default:
            return @"General Features";
    }
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( [self.categories[section][@"name"]  isEqual: @"Distance"] ){
        if(!self.distanceExpanded){
            return 1;
        } else {
            return ((NSArray *)self.categories[section][@"list"]).count;
        }
    } else if( [self.categories[section][@"name"]  isEqual: @"Sort By"] ){
        if(!self.sortByExpanded){
            return 1;
        } else {
            return ((NSArray *)self.categories[section][@"list"]).count;
        }
    } else if([self.categories[section][@"name"]  isEqual: @"General Features"]) {
        if(!self.featuresExpanded){
            return 4;
        } else {
            // Adds one for the colapse cell
            return ((NSArray *)self.categories[section][@"list"]).count;
        }
    } else if ([self.categories[section][@"name"]  isEqual: @"Price"]){
        return 1;
    } else {
        return ((NSArray *)self.categories[section][@"list"]).count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([self.categories[indexPath.section][@"name"]  isEqual: @"General Features"] && !self.featuresExpanded && indexPath.row == 3) {
        SeeAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeAllCell" forIndexPath:indexPath];
        return cell;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Price"] ) {
        SegmentedPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegmentedPriceCell" forIndexPath:indexPath];
        return cell;
        
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
        
        if ([self.categories[indexPath.section][@"name"] isEqual: @"Price"] || [self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"] || [self.categories[indexPath.section][@"name"]  isEqual: @"General Features"]){
            cell.accessoryView = [[UISwitch alloc] init];
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Distance"] || [self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"row: %d", indexPath.row);
    NSLog(@"section: %d", indexPath.section);
    
    if([self.categories[indexPath.section][@"name"]  isEqual: @"Distance"]){
        self.distanceExpanded = !self.distanceExpanded;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]) {
        self.sortByExpanded = !self.sortByExpanded;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"General Features"]) {
        self.featuresExpanded = !self.featuresExpanded;
    }
    
    [self.tableView reloadData];
    
}

@end
