//
//  ResultsLIstViewController.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "ResultsLIstViewController.h"
#import "FiltersViewController.h"
#import "YelpClient.h"
#import "YelpListingCell.h"
#import "YelpListing.h"
#import <AFNetworking/UIImageView+AFNetworking.h>


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ResultsLIstViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *yelpListings;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *restaurantsArray;
@property (nonatomic, assign) int offset;
@property (nonatomic, strong) UIView *searchBarView;

@end

@implementation ResultsLIstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *yelpNib = [UINib nibWithNibName:@"YelpListingCell" bundle:nil];
    [self.tableView registerNib:yelpNib forCellReuseIdentifier:@"YelpListingCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    UINavigationBar *header = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,45)];
    UINavigationItem *buttonStore = [[UINavigationItem alloc]initWithTitle:@"Yelp"];
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(onFilter:)];
    
    [buttonStore setLeftBarButtonItem:filterButton];
    
    NSArray *barItemsArray = [[NSArray alloc]initWithObjects:buttonStore,nil];
    [header setItems:barItemsArray];
    [self.tableView setTableHeaderView:header];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBarView addSubview:self.searchBar];
    header.topItem.titleView = self.searchBar;


    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        self.yelpListings = [YelpListing yelpListingsArray:response[@"businesses"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    YelpListing *listing = [self.yelpListings objectAtIndex:indexPath.row];
    
//    NSString *restaurantTitleText = listing.title;
//    UIFont *restaurantTitleFont = [UIFont boldSystemFontOfSize:15.0];
//    CGRect rectForRestaurantTitle = [restaurantTitleText boundingRectWithSize:CGSizeMake(120, CGFLOAT_MAX)
//                                                                    options:NSStringDrawingUsesLineFragmentOrigin
//                                                                 attributes:@{NSFontAttributeName:restaurantTitleFont}
//                                                                    context:nil];
//    // Restaurant Address
//    NSString *restaurantAddressText = listing.address;
//    UIFont *restaurantAddressFont = [UIFont systemFontOfSize:13.0];
//    CGRect rectForAddress = [restaurantAddressText boundingRectWithSize:CGSizeMake(205, CGFLOAT_MAX)
//                                                                options:NSStringDrawingUsesLineFragmentOrigin
//                                                             attributes:@{NSFontAttributeName:restaurantAddressFont}
//                                                                context:nil];
//    
//    // Restaurant Categories
//    NSString *restaurantCategoriesText = listing.categories;
//    UIFont *restaurantCategoriesFont = [UIFont italicSystemFontOfSize:13.0];
//    CGRect rectForCategories = [restaurantCategoriesText boundingRectWithSize:CGSizeMake(205, CGFLOAT_MAX)
//                                                                      options:NSStringDrawingUsesLineFragmentOrigin
//                                                                   attributes:@{NSFontAttributeName:restaurantCategoriesFont}
//                                                                      context:nil];
//    
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

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    UITextField *searchBarTextField;
//    
//    for (UIView *subView in searchBar.subviews){
//        for (UIView *secondLeveSubView in subView.subviews){
//            if ([secondLeveSubView isKindOfClass:[UITextField class]]) {
//                searchBarTextField = (UITextField *)secondLeveSubView;
//                break;
//            }
//        }
//    }
//}

#pragma mark - Navigation Bar

- (void)onFilter
{
    [self.searchBar resignFirstResponder];
    FiltersViewController *filtersViewController = [[FiltersViewController alloc] initWithNibName:NSStringFromClass([FiltersViewController class]) bundle:nil];
    [self presentViewController:filtersViewController animated:YES completion:^{}];
    return;
}
@end
