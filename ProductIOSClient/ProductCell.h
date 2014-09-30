//
//  ProductCell.h
//  ProductIOSClient
//
//  Created by Shao Wei on 6/28/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BMapKit.h"
#import "SubCell.h"
#import "ExpandCell.h"
#import "ProductIOSCLientViewController.h"
#import "LocationAnnotation.h"

@class ProductIOSCLientViewController;

@interface ProductCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
{
    
}

@property (weak, nonatomic) IBOutlet UIButton *expandButton;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (nonatomic) int subCellNumber;
@property (nonatomic) BOOL isExpanded;
@property (nonatomic) BOOL isProductExpanded;
@property (nonatomic) BOOL isMapExpanded;
@property (nonatomic) NSString *productCellText;
@property (strong, nonatomic) NSString *productImageName;
@property (strong, nonatomic) NSMutableArray *subCellInfo;
@property (nonatomic) ProductIOSCLientViewController *parentTableView;
@property (strong, nonatomic) UIImageView *arrowImageView;
@property (strong, nonatomic) UILabel *buttonLabel;
@property (strong, nonatomic) MKMapView *tinyMapView;


@end
