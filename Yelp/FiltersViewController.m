//
//  FiltersViewController.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *categories;
@property (nonatomic, assign) BOOL featuresExpanded;

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

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Price";
    } else if (section == 1) {
        return @"Most Popular";
    } else if (section == 2){
        return @"Distance";
    } else if (section == 3){
        return @"Sort By";
    } else {
        return @"General Features";
    }
}

@end
