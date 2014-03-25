//
//  Filters.m
//  Yelp
//
//  Created by Tripta Gupta on 3/25/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "Filters.h"

@interface Filters ()

@end

@implementation Filters

- (id)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        _sortOptions = @[@"Best matched", @"Distance", @"Highest Rated"];
        _sort = 0;

        //Search radius in meters
        _radiusOptions = @[@100, @200, @500, @1000, @10000];
        _radius = 4;
        
        _sectionTitles = @[@"Sort", @"Distance", @"Deals", @"Category"];
        _offerDeals = false;
        
        NSDictionary *categoryDict = @{@"Active Life": @"active",
                                       @"Arts & Entertainment" : @"arts",
                                       @"Automotive" : @"auto",
                                       @"Beauty & Spas" : @"beautysvc",
                                       @"Education" : @"education",
                                       @"Event Planning & Services" : @"eventservices",
                                       @"Financial Services" : @"financialservices",
                                       @"Food" : @"food",
                                       @"Health & Medical" : @"health",
                                       @"Home Services" : @"homeservices",
                                       @"Hotels & Travel" : @"hotelstravel",
                                       @"Local Services" : @"localservices",
                                       @"Nightlife" : @"nightlife",
                                       @"Pets" : @"pets",
                                       @"Professional Services" : @"professional",
                                       @"Public Services & Government" : @"publicservicesgovt",
                                       @"Real Estate" : @"realestate",
                                       @"Restaurants" : @"restaurants",
                                       @"Shopping" : @"shopping"
                                       };
        _categories = [[categoryDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    return self;
}

- (NSString *)getRadiusFilter {
    
    return [_radiusOptions objectAtIndex:_radius];
}

- (NSString *)labelForRadiusAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%@ m", [_radiusOptions objectAtIndex:index]];
}

- (NSString *)getSortFilter {
    return [NSString stringWithFormat:@"%ld", (long)_sort];
}

- (NSDictionary *)getParametersTerm:(NSString *)term {
    return @{
             @"term" : term,
             @"sort" : [NSString stringWithFormat:@"%ld", (long)_sort],
             @"location" : @"San Francisco",
             @"deals_filter" : _offerDeals ? @"true" : @"false",
             @"radius_filter" : [self getRadiusFilter]
             };
}


@end
