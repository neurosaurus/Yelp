//
//  ResultsLIstViewController.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "ResultsLIstViewController.h"
#import "YelpClient.h"
#import "YelpListingCell.h"
#import "YelpListing.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ResultsLIstViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *yelpListings;
@property (nonatomic, strong) YelpClient *client;

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
    self.tableView.rowHeight = 130;
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;

    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        self.yelpListings = [YelpListing yelpListingsArray:response[@"businesses"]];
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

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yelpListings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YelpListingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpListingCell" forIndexPath:indexPath];
    
    YelpListing *listing = self.yelpListings[indexPath.row];
    
    // Used to set indexLabel to number listings on custom cell
    listing.index    = [NSString stringWithFormat: @"%i", indexPath.row];
    
    cell.yelpListing = listing;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get instance of cell
    YelpListingCell *cell = [tableview cellForRowAtIndexPath:indexPath];
    
    // Prototype knows how to calculate its height for the given data
    return [cell customHeightForCell];
}
@end
