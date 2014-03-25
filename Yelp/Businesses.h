//
//  Businesses.h
//  Yelp
//
//  Created by Tripta Gupta on 3/25/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YelpListing;

@interface Businesses : NSObject

@property (nonatomic, strong) NSArray *data;
- (NSUInteger)count;
- (YelpListing *)get:(NSUInteger)index;

@end
