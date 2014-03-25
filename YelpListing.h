//
//  YelpListing.h
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpListing : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *reviewCount;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *neighborhood;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *listingImageUrl;
@property (nonatomic, strong) NSString *ratingImageUrl;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) NSMutableArray *categoriesArray;
@property (nonatomic, strong) NSArray *data;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end