//
//  YelpListingCell.h
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpListing.h"

@interface YelpListingCell : UITableViewCell

@property (nonatomic, strong) YelpListing *yelpListing;

- (CGFloat) customHeightForCell;

@end


