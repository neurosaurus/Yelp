//
//  Businesses.m
//  Yelp
//
//  Created by Tripta Gupta on 3/25/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "Businesses.h"
#import "YelpListing.h"

@implementation Businesses

- (id)init
{
    self = [super init];
    if (self) {
        _data = [[NSArray alloc] init];
    }
    return self;
}

- (NSUInteger)count
{
    return [_data count];
}

- (YelpListing *)get:(NSUInteger)index
{
    if (index < [self count]) {
        NSDictionary *dict = _data[index];
        return [[YelpListing alloc] initWithDictionary:dict];
    } else {
        return nil;
    }
}

@end
