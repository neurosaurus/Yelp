//
//  FiltersViewController.h
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

@protocol FilterViewCellDelegate <NSObject>

- (void)filterSettings:(NSMutableDictionary *)data;

@end

#import <UIKit/UIKit.h>
#import "FilterViewCell.h"
#import "SegmentedPriceCell.h"


@interface FiltersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<FilterViewCellDelegate> delegate;

@end
