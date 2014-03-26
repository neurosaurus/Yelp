//
//  SegmentedPriceCell.m
//  Yelp
//
//  Created by Tripta Gupta on 3/23/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "SegmentedPriceCell.h"

@implementation SegmentedPriceCell

- (void)awakeFromNib
{
    //[self.segments addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
