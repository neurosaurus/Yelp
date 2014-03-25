//
//  ResultsLIstViewController.h
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersViewController.h"

@class Businesses;
@class Filters;

@interface ResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) Businesses *listingResults;
@property (nonatomic, strong) Filters *filters;

@end
