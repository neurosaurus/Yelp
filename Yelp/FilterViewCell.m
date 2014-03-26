//
//  FilterViewCell.m
//  Yelp
//
//  Created by Tripta Gupta on 3/23/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "FilterViewCell.h"

@interface FilterViewCell ()

- (void)didChangeValue:(id)sender;

@end

@implementation FilterViewCell

- (void)awakeFromNib
{
    [self.onSwitch addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didChangeValue:(id)sender {
    [self.delegate sender:self didChangeValue:self.onSwitch.on];
}

@end
