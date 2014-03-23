//
//  YelpListing.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "YelpListing.h"

@implementation YelpListing

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title            = dictionary[@"name"];
        self.ratingImageUrl   = dictionary[@"rating_img_url"];
        self.reviewCount      = dictionary[@"review_count"];
        self.address          = dictionary[@"location"][@"display_address"][0];
        self.neighborhood     = dictionary[@"location"][@"display_address"][2];
        self.listingImageUrl  = dictionary[@"image_url"];
        
}
    return self;
}

+ (NSArray *)yelpListingsArray:(NSArray *)array
{
    NSLog(@"yelpListingsWithArray");
    NSMutableArray *yelpListings = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        YelpListing *listing = [[YelpListing alloc] initWithDictionary:dictionary];
        NSLog(@"name: %@, reviews: %@, address: %@", listing.title, listing.reviewCount, listing.address);
        
        [yelpListings addObject:listing];
    }
    NSLog(@"Finishing yelpListingsWithArray");
    return yelpListings;
}

@end