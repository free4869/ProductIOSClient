//
//  SubCell.m
//  ProductIOSClient
//
//  Created by Shao Wei on 6/28/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "SubCell.h"

@implementation SubCell
@synthesize marketLabel = _marketLabel;
@synthesize priceLabel = _priceLabel;
@synthesize addressLabel = _addressLabel;
@synthesize borderView = _borderView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
