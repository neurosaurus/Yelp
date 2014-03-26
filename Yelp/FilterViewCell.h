//
//  FilterViewCell.h
//  Yelp
//
//  Created by Tripta Gupta on 3/23/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

@class FilterViewCell;

@protocol FilterViewCellDelegate <NSObject>

@optional
- (void)sender:(FilterViewCell *)sender didChangeValue:(BOOL)value;

@end

#import <UIKit/UIKit.h>

@interface FilterViewCell : UITableViewCell

//@property (nonatomic,strong) NSString *categoryName;
@property (nonatomic, assign) id<FilterViewCellDelegate> delegate;


@end
