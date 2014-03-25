//
//  ResultsLIstViewController.h
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersViewController.h"

@class YelpListing;
@class Filters;

@interface ResultsLIstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) YelpListing *listingResults;
@property (nonatomic, strong) Filters *filters;

@end
