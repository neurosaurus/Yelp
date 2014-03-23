//
//  YelpListingCell.m
//  Yelp
//
//  Created by Tripta Gupta on 3/22/14.
//  Copyright (c) 2014 Tripta Gupta. All rights reserved.
//

#import "YelpListingCell.h"
#import "UIImageView+AFNetworking.h"

@interface YelpListingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantTitle;
@property (weak, nonatomic) IBOutlet UILabel *indexCount;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCount;
@property (weak, nonatomic) IBOutlet UIImageView *ratingsImage;

@end

@implementation YelpListingCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)setYelpListing:(YelpListing *)listing
{
    _listing = listing;
    
    self.restaurantTitle.text   = listing.title;
    self.addressLabel.text      = [NSString stringWithFormat:@"%@, %@", listing.address, listing.neighborhood];
    self.reviewCount.text       = [NSString stringWithFormat: @"%@", listing.reviewCount];
    self.indexCount.text        = listing.index;
    
    [self.restaurantImage       setImageWithURL: [NSURL URLWithString:listing.listingImageUrl]];
    [self.ratingsImage          setImageWithURL: [NSURL URLWithString:listing.ratingImageUrl]];
}

@end