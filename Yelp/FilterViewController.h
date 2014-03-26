//
//  FiltersViewController.h
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewCell.h"
#import "SegmentedPriceCell.h"

@class FilterViewController;

@protocol FilterViewDelegate <NSObject>

- (void)filterSettings:(NSMutableDictionary *)data;

@end


@interface FilterViewController : UIViewController <FilterViewCellDelegate>

@property (nonatomic, assign) id<FilterViewDelegate> delegate;

@end
