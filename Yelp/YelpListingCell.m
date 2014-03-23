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
- (void)setYelpListing:(YelpListing *)yelpListing
{
    _yelpListing = yelpListing;
    
    self.restaurantTitle.text   = [NSString stringWithFormat:@"%@, %@", yelpListing.index, yelpListing.title];
    self.addressLabel.text      = [NSString stringWithFormat:@"%@, %@", yelpListing.address, yelpListing.neighborhood];
    self.reviewCount.text       = [NSString stringWithFormat: @"%@", yelpListing.reviewCount];
    self.indexCount.text        = yelpListing.index;
    
    [self.restaurantImage       setImageWithURL: [NSURL URLWithString:yelpListing.listingImageUrl]];
    [self.ratingsImage          setImageWithURL: [NSURL URLWithString:yelpListing.ratingImageUrl]];
}

//- (CGFloat)customHeightForCell
//{
//    self.restaurantTitle.text = yelpListing.name
// 
//    //UIFont *fontText = [UIFont systemFontOfSize:15.0];
//    CGRect rect = [text boundingRectWithSize:CGSizeMake(165, CGFLOAT_MAX)
//                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                  attributes:@{NSFontAttributeName:fontText}
//                                     context:nil];
//    CGFloat heightOffset = 90;
//    return rect.size.height + heightOffset;
//    
//}

@end