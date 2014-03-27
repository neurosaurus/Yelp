//
//  FilterViewController.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "FilterViewController.h"
#import "SeeAllCell.h"
#import "SegmentedPriceCell.h"
#import "Filters.h"
#import "FilterViewCell.h"

@interface FilterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *categories;
@property (nonatomic, assign) BOOL featuresExpanded;
@property (nonatomic, assign) BOOL sortByExpanded;
@property (nonatomic, assign) BOOL distanceExpanded;
@property (nonatomic, assign) BOOL categoriesExpanded;
@property (nonatomic, strong) NSMutableArray *price;
@property (nonatomic, strong) NSMutableArray *popular;
@property (nonatomic, strong) NSMutableArray *distance;
@property (nonatomic, strong) NSMutableArray *sortBy;
@property (nonatomic, strong) NSMutableArray *generalFeatures;
@property (nonatomic, strong) NSMutableArray *categoriesFeatures;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.categories = [NSMutableArray arrayWithObjects:@{
                                                             @"name":@"Price",
                                                             @"type":@"segmented",
                                                             @"list":@[@"$",@"$$",@"$$$",@"$$$$"],
                                                             @"values":@1
                                                             },
                           @{
                             @"name":@"Most Popular",
                             @"type":@"switches",
                             @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
                             },
                           @{
                             @"name":@"Distance",
                             @"type":@"expandable",
                             @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"],
                             @"values":@[@(NO), @(NO), @(NO), @(NO), @(NO)]
                             },
                           @{
                             @"name":@"Sort By",
                             @"type":@"expandable",
                             @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"],
                             @"values":@[@(NO), @(NO), @(NO), @(NO)]
                             },
                           @{
                             @"name":@"General Features",
                             @"type":@"expandable",
                             @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"],
                             @"values":@[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)]
                             },
                           @{
                             @"name":@"Categories",
                             @"type":@"switches",
                             @"list":@[@"All",@"Active Live",@"Arts & Entertainment",@"Automotive",@"Beauty & Spas",@"Education",@"Event Planning & Services"],
                             @"values":@[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)]
                             }, nil];
        
        
        self.popular = [NSMutableArray arrayWithObjects: @(NO), @(NO), @(NO), @(NO), nil];
        self.price = [NSMutableArray arrayWithObjects: @(0), nil];
        self.distance = [NSMutableArray arrayWithObjects: @(YES), @(NO), @(NO), @(NO), @(NO), nil];
        self.sortBy = [NSMutableArray arrayWithObjects: @(YES), @(NO), @(NO), @(NO), nil];
        self.generalFeatures = [NSMutableArray arrayWithObjects: @(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(NO), @(NO), @(YES), @(NO), nil];
        self.categoriesFeatures = [NSMutableArray arrayWithObjects: @(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(NO), nil];
        
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
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterViewCell" bundle:nil] forCellReuseIdentifier:@"FilterViewCell"];
    UINavigationBar *header = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,45)];
    
    UINavigationItem *buttonHold = [[UINavigationItem alloc]initWithTitle:@"Filter"];
    
    UIBarButtonItem *barBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancel)];
    UIBarButtonItem *barSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveFilter)];
    
    [buttonHold setLeftBarButtonItem:barBackButton];
    [buttonHold setRightBarButtonItem:barSaveButton];
    
    NSArray *barItemArray = [[NSArray alloc]initWithObjects:buttonHold,nil];
    
    [header setItems:barItemArray];
    
    [self.tableView setTableHeaderView:header];
}

#pragma mark - Buttons
- (void)onCancel
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    return;
}


#pragma mark - Filter Delegate
- (void)saveFilter
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    
    [filters setObject:self.popular forKey:@"popular"];
    [filters setObject:self.distance forKey:@"distance"];
    [filters setObject:self.sortBy forKey:@"sortBy"];
    [filters setObject:self.generalFeatures forKey:@"generalFeaturesPopular"];
    [filters setObject:self.categoriesFeatures forKey:@"categoriesPopular"];

    NSLog(@"press save button");
    [self filterSettings:filters];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)sender:(FilterViewCell *)sender didChangeValue:(BOOL)value{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if (indexPath.section == 1) {
        self.popular[indexPath.row] = @(value);
    } else if (indexPath.section == 4) {
        self.generalFeatures[indexPath.row] = @(value);
    } else if (indexPath.section == 5) {
        self.categoriesFeatures[indexPath.row] = @(value);
    }
}

- (void)filterSettings:(NSMutableDictionary *)data
{
    if ([self.delegate respondsToSelector:@selector(filterSettings:)]) {
        [self.delegate filterSettings:data];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.categories.count;
}

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
        case 4:
            return @"General Features";
        default:
            return @"Categories";
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
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Categories"] && !self.categoriesExpanded && indexPath.row == 3) {
        SeeAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeAllCell" forIndexPath:indexPath];
        return cell;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Price"] ) {
        SegmentedPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegmentedPriceCell" forIndexPath:indexPath];
        return cell;
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"] || [self.categories[indexPath.section][@"name"]  isEqual: @"General Features"] || [self.categories[indexPath.section][@"name"]  isEqual: @"Categories"]) {
        FilterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterViewCell" forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.switchLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
        
        if([self.categories[indexPath.section][@"name"]  isEqual: @"Most Popular"]){
            cell.onSwitch.on = [self.popular[indexPath.row] boolValue];
            return cell;
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"General Features"]) {
            cell.onSwitch.on = [self.generalFeatures[indexPath.row] boolValue];
            return cell;
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Categories"]) {
            cell.onSwitch.on = [self.categoriesFeatures[indexPath.row] boolValue];
            return cell;
        } else {
            cell.onSwitch.on = [self.categories[indexPath.section][@"values"][indexPath.row] boolValue];
            return cell;
        }
        
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
        
        if ([self.categories[indexPath.section][@"name"]  isEqual: @"Distance"]){
            if ([self.distance[indexPath.row] boolValue]){
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Sort By"]){
            if ([self.sortBy[indexPath.row] boolValue]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
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
    } else if ([self.categories[indexPath.section][@"name"]  isEqual: @"Categories"] && indexPath.row == 3 && !self.categoriesExpanded) {
    self.categoriesExpanded = !self.categoriesExpanded;
    }

    [self.tableView reloadData];
    
}

@end
