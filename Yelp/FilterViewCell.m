//
//  FilterViewCell.m
//  Yelp
//
//  Created by Tripta Gupta on 3/23/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "FilterViewCell.h"

@implementation FilterViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didChangeValue:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sender:didChangeValue:)]) {
        [self.delegate sender:self didChangeValue:((UISwitch*)self.accessoryView).on];
    }
}

@end
