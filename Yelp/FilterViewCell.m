//
//  FilterViewCell.m
//  Yelp
//
//  Created by Tripta Gupta on 3/23/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "FilterViewCell.h"

@interface FilterViewCell()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UISwitch *buttonSwitch;

@end

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

- (void)setName:(NSString *)name {
    self.categoryLabel.text = name;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    //NSLog(@"highlighted cell");
}

@end
