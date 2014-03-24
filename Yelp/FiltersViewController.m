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
        self.title = @"Filters";
           }
    return self;
}

- (void)viewDidLoad
{ 
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButton:)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel:)];

    
    UINib *filterViewCellNib = [UINib nibWithNibName:@"FilterViewCell" bundle:nil];
    [self.tableView registerNib:filterViewCellNib forCellReuseIdentifier:@"FilterViewCell"];
    
    UINib *seeAllNib = [UINib nibWithNibName:@"SeeAllCell" bundle:nil];
    [self.tableView registerNib:seeAllNib forCellReuseIdentifier:@"SeeAllCell"];
    
    UINib *segmentedPricelNib = [UINib nibWithNibName:@"SegmentedPriceCell" bundle:nil];
    [self.tableView registerNib:segmentedPricelNib forCellReuseIdentifier:@"SegmentedPriceCell"];
    
    [self setupCategories];
}

- (void)setupCategories
{    
    self.categories = [NSMutableArray arrayWithObjects:
                       @{
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
                         @"type":@"switches",
                         @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"]
                         },
                       nil
                       ];
}

#pragma mark - Buttons
- (void)onCancel:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSearchButton:(UIBarButtonItem *)button
{
    NSLog(@"Search");
    //[self.delegate filtersViewController:self didSetFilters:_filters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods -- Datasource

//- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.categories count];
//}

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
        SegmentedPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceCell" forIndexPath:indexPath];
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
