//
//  ResultsLIstViewController.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "ResultsViewController.h"
#import "FilterViewController.h"
#import "YelpClient.h"
#import "YelpListingCell.h"
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
//        self.title = @"Yelp";
//        self.searchTerm = @"Pho";
//        _filters = [[Filters alloc] init];
//        self.listingResults = [[Businesses alloc] init];
//        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
//
//        UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
//                                                                         style:UIBarButtonItemStylePlain
//                                                                        target:self
//                                                                        action:@selector(onFilter:)];
//        
//        self.navigationItem.rightBarButtonItem = filterButton;
//        
//        UISearchBar *searchBar = [[UISearchBar alloc] init];
//        searchBar.delegate = self;
//        searchBar.text = self.searchTerm;
//        self.navigationItem.titleView = searchBar;
    }
    return self;
}

//- (void)loadYelp
//{
//    NSDictionary *parameters = [_filters getParametersTerm:self.searchTerm];
//    
//    [self.client searchWithParameters:parameters success:^(AFHTTPRequestOperation *operation, id response) {
//        self.listingResults.data = response[@"businesses"];
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error: %@", [error description]);
//    }];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *yelpNib = [UINib nibWithNibName:@"YelpListingCell" bundle:nil];
    [self.tableView registerNib:yelpNib forCellReuseIdentifier:@"YelpListingCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilter)];
    
    UINavigationBar *headerView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,20,320,44)];
    
    UINavigationItem *buttonCarrier = [[UINavigationItem alloc]initWithTitle:@"whatever"];

    
    UIBarButtonItem *barBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(filter)];
    [buttonCarrier setLeftBarButtonItem:barBackButton];
    NSArray *barItemArray = [[NSArray alloc]initWithObjects:buttonCarrier,nil];
    [headerView setItems:barItemArray];
    [self.tableView setTableHeaderView:headerView];
    
    [headerView setBarTintColor:[UIColor redColor]];
    [headerView setTintColor:[UIColor whiteColor]];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    headerView.topItem.titleView = self.searchBar;
    
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Pho" success:^(AFHTTPRequestOperation *operation, id response) {

        self.yelpListings = [YelpListing yelpListingsWithArray:response[@"businesses"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods -- Datasource

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.yelpListings.count;
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
    
    cell.yelpListing = listing;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpListing *listing = self.yelpListings[indexPath.row];
    
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
    [searchBar resignFirstResponder];
    NSString *searchText = searchBar.text;
    
    [self.client searchWithTerm:searchText success:^(AFHTTPRequestOperation *operation, id response) {
        // Passing API results to the YelpListing model for creation
        self.yelpListings = [YelpListing yelpListingsWithArray:response[@"businesses"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}

- (void)filterSettings:(NSMutableDictionary *)data
{
    NSLog(@"beings passed from filtersview");
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSLog(@"%@", data);
    if (data[@"popular"][2]) {
        [dictionary setObject:data[@"popular"][2] forKey:@"deals_filter"];
    }
        
//    if (data[@"distance"][0]) {
//        [dictionary setObject:@"100" forKey:@"radius_filter"];
//    } else if (data[@"distance"][1]) {
//        [dictionary setObject:@"500" forKey:@"radius_filter"];
//    } else if (data[@"distance"][2]) {
//        [dictionary setObject:@"1000" forKey:@"radius_filter"];
//    } else if (data[@"distance"][3]) {
//        [dictionary setObject:@"20000" forKey:@"radius_filter"];
//    }
    
    [self.client searchWithDictionary:dictionary success:^(AFHTTPRequestOperation *operation, id response) {
        self.yelpListings = [YelpListing yelpListingsWithArray:response[@"businesses"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

#pragma mark - Navigation Bar

- (void)onFilter
{
    [self.navigationController pushViewController:[[FilterViewController alloc] init] animated:YES];

}

- (void)filter {
    [self.searchBar resignFirstResponder];
    FilterViewController *filterViewController = [[FilterViewController alloc] initWithNibName:NSStringFromClass([FilterViewController class]) bundle:nil];
    filterViewController.delegate = self;
    [self presentViewController:filterViewController animated:YES completion:^{}];
    return;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
@end
