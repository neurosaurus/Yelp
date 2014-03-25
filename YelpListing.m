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
        self.categoriesArray  = dictionary[@"categories"];
        self.categories = @"";
        for (int i = 0; i < self.categoriesArray.count; i++)
        {
            if (i == 0)
            {
                self.categories = self.categoriesArray[i][0];
            }
            else
            {
                self.categories = [self.categories stringByAppendingFormat:@", %@", self.categoriesArray[i][0]];
            }
        }
    }
    return self;
}

@end