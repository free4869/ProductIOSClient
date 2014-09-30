//
//  SampleSubCell.m
//  ProductIOSClient
//
//  Created by Shao Wei on 7/19/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "SampleSubCell.h"

@implementation SampleSubCell

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
