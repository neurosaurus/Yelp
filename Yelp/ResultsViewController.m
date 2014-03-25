//
//  ResultsLIstViewController.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "ResultsViewController.h"
#import "FiltersViewController.h"
#import "YelpClient.h"
#import "YelpListingCell.h"
#import "Filters.h"
#import "Businesses.h"
#import "YelpListing.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ResultsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *yelpListings;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *restaurantsArray;
@property (nonatomic, strong) UIView *searchBarView;
@property (strong, nonatomic) NSString *searchTerm;

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Yelp";
        self.searchTerm = @"Pho";
        _filters = [[Filters alloc] init];
        self.listingResults = [[Businesses alloc] init];
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];

        UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(onFilter:)];
        
        self.navigationItem.rightBarButtonItem = filterButton;
        
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.delegate = self;
        searchBar.text = self.searchTerm;
        self.navigationItem.titleView = searchBar;
    }
    return self;
}

- (void)loadYelp
{
    NSDictionary *parameters = [_filters getParametersTerm:self.searchTerm];
    
    [self.client searchWithParameters:parameters success:^(AFHTTPRequestOperation *operation, id response) {
        self.listingResults.data = response[@"businesses"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *yelpNib = [UINib nibWithNibName:@"YelpListingCell" bundle:nil];
    [self.tableView registerNib:yelpNib forCellReuseIdentifier:@"YelpListingCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    [self loadYelp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods -- Datasource

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpListingCell" forIndexPath:indexPath];
    YelpListing *listing = self.yelpListings[indexPath.row];
    listing.index    = [NSString stringWithFormat: @"%i", indexPath.row];
    
    cell.yelpListing = [_listingResults get:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpListing *listing = [_listingResults get:indexPath.row];
    
    NSString *text = listing.title;
    UIFont *fontText = [UIFont boldSystemFontOfSize:15.0];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(165, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontText}
                                     context:nil];
    CGFloat heightOffset = 90;
    return rect.size.height + heightOffset;
}

#pragma mark Search

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    self.searchTerm = searchBar.text;
    [self loadYelp];

}

- (void)filtersViewController:(FiltersViewController *)filtersViewController
                didSetFilters:(Filters *)filters
{
    if (nil != filters) {
        _filters = filters;
        [self loadYelp];
    }
    [self dismissViewControllerAnimated:YES completion: nil];
}

#pragma mark - Navigation Bar

- (void)onFilter:(UIBarButtonItem *)button
{
    FiltersViewController *fvc = [[FiltersViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:fvc];
    [self presentViewController:navigationController animated:YES completion: nil];
}
@end
