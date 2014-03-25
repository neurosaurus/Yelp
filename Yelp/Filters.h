//
//  Filters.h
//  Yelp
//
//  Created by Tripta Gupta on 3/25/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSArray *sortOptions;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, strong) NSArray *radiusOptions;
@property (nonatomic, assign) BOOL offerDeals;
- (NSDictionary *)getParametersWithTerm:(NSString *)term;
- (NSString *)labelForRadiusAtIndex:(NSInteger)index;

@end