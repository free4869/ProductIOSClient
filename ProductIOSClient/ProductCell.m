//
//  ProductCell.m
//  ProductIOSClient
//
//  Created by Shao Wei on 6/28/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "ProductCell.h"

#define SAMPLE_QUESTION 

@implementation ProductCell

@synthesize subTableView = _subTableView;
@synthesize parentTableView = _parentTableView;
@synthesize expandButton = _expandButton;
@synthesize isExpanded = _isExpanded;
@synthesize isProductExpanded = _isProductExpanded;
@synthesize isMapExpanded = _isMapExpanded;
@synthesize subCellNumber = _subCellNumber;
@synthesize productCellText = _productCellText;
@synthesize productImageName = _productImageName;
@synthesize subCellInfo = _subCellInfo;
@synthesize arrowImageView = _arrowImageView;
@synthesize buttonLabel = _buttonLabel;
@synthesize tinyMapView = _tinyMapView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    [self.subTableView setDelegate:self];
    [self.subTableView setDataSource:self];
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (NSNumber *)averageOfArray:(NSArray *)array
{
    double averageNumber = 0;
    for (NSNumber *n in array)
        averageNumber = averageNumber + [n doubleValue];
    return [NSNumber numberWithDouble:(averageNumber / [array count])];
}


#pragma mark - UITableView dataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.subCellNumber == 1)
        return 4;
    else if (self.isExpanded)
    {
        if ([self.subCellInfo count] == 1)
            return 2;
        if (!self.isProductExpanded)
            return 3;
        else
            return [self.subCellInfo count] + 1;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.subCellNumber == 1)
    {
        SubCell *cell;
        cell = (SubCell*)[tableView dequeueReusableCellWithIdentifier:@"Sample Sub Cell"];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SampleSubCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.borderView.layer.borderWidth = 1.5;
        cell.borderView.layer.borderColor = [[UIColor colorWithRed:0.707 green:0.711 blue:0.707 alpha:1] CGColor];
        cell.borderView.layer.cornerRadius = 8;
        cell.borderView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        cell.selectedBackgroundView = nil;
        UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 15, 260, 13)];
        questionLabel.font = [UIFont systemFontOfSize:13];
        if ([indexPath row] == 0)
            questionLabel.text = @"北京的西红柿什么价格？";
        else if ([indexPath row] == 1)
            questionLabel.text = @"河南西瓜的价格？";
        else if ([indexPath row] == 2)
            questionLabel.text = @"北京京丰岳各庄批发市场黄瓜多少钱一斤？";
        else if ([indexPath row] == 3)
            questionLabel.text = @"鸡蛋怎么卖？";
        [cell.contentView addSubview:questionLabel];
        return cell;
    }
    else
    {
        SubCell *cell;
        cell = (SubCell*)[tableView dequeueReusableCellWithIdentifier:@"Sub Cell"];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SubCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.borderView.layer.borderWidth = 1.5;
        cell.borderView.layer.borderColor = [[UIColor colorWithRed:0.707 green:0.711 blue:0.707 alpha:1] CGColor];
        cell.borderView.layer.cornerRadius = 8;
        cell.borderView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        if ([indexPath row] == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            NSMutableArray *prices = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in self.subCellInfo)
            {
                [prices addObject:[NSNumber numberWithDouble:[[dic objectForKey:@"price"] doubleValue]]];
            }
            NSNumber *averagePrice = [self averageOfArray:prices];
            
            UILabel *averageLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 8, 180, 13)];
            averageLabel.font = [UIFont systemFontOfSize:12];
            averageLabel.text = [NSString stringWithFormat:@"平均批发价:%.2f 元/公斤", [averagePrice doubleValue]];
            UILabel *adviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 24, 180, 13)];
            adviceLabel.font = [UIFont systemFontOfSize:12];
            adviceLabel.text = [NSString stringWithFormat:@"建议零售价:%.2f~%.2f 元/公斤", [averagePrice doubleValue] * 2, [averagePrice doubleValue] * 2.5];
            NSString *path = [[NSBundle mainBundle] pathForResource:self.productImageName ofType:nil];
            UIImage *myImage = [UIImage imageWithContentsOfFile:path];
            UIImageView *productFrame = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
            [productFrame setImage:[UIImage imageNamed:@"product_frame.png"]];
            UIImageView *productImage = [[UIImageView alloc] initWithImage:myImage];
            [productImage setFrame:CGRectMake(15, 10, 50, 50)];
            NSArray *views = [cell.contentView subviews];
            for (id view in views)
            {
                if ([view isKindOfClass:[UILabel class]])
                    [view removeFromSuperview];
            }
            [cell.contentView addSubview:averageLabel];
            [cell.contentView addSubview:adviceLabel];
            [cell.contentView addSubview:productFrame];
            [cell.contentView addSubview:productImage];
        }
        else
        {
            UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 14, 260, 13)];
            productLabel.font = [UIFont systemFontOfSize:13];
            productLabel.text = [[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"product"];
            UILabel *marketNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 34, 260, 13)];
            marketNameLabel.font = [UIFont systemFontOfSize:13];
            marketNameLabel.text = [[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"name"];
            UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 54, 260, 13)];
            addressLabel.font = [UIFont systemFontOfSize:13];
            addressLabel.text = [NSString stringWithFormat:@"地址:%@", [[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"address"]];
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 74, 260, 13)];
            priceLabel.font = [UIFont systemFontOfSize:13];
            priceLabel.text = [NSString stringWithFormat:@"批发价:%@", [[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"price"]];
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 94, 260, 13)];
            dateLabel.font = [UIFont systemFontOfSize:13];
            dateLabel.text = [NSString stringWithFormat:@"更新时间:%@", [[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"date"]];
            UILabel *marketNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 50, 18, 10)];
            marketNumberLabel.text = [NSString stringWithFormat:@"%i", [indexPath row]];
            marketNumberLabel.font = [UIFont systemFontOfSize:14];
            marketNumberLabel.textColor = [UIColor redColor];
            [cell.contentView addSubview:productLabel];
            [cell.contentView addSubview:marketNameLabel];
            [cell.contentView addSubview:addressLabel];
            [cell.contentView addSubview:priceLabel];
            [cell.contentView addSubview:dateLabel];
            [cell.contentView addSubview:marketNumberLabel];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.subCellNumber == 1)
        return 40;
    else if (!self.isExpanded)
        return 0;
    else if ([indexPath row] == 0)
        return 70;
    else
        return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.subCellNumber != 1 && [indexPath row] != 0)
    {
        //baidu map
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"lat"] doubleValue];
        coordinate.longitude = [[[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"lng"] doubleValue];
        
        self.parentTableView.bmvController.annotation.coordinate = coordinate;
        self.parentTableView.bmvController.annotation.title = [[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"name"];
        NSString *add = @"地址:";
        self.parentTableView.bmvController.annotation.subtitle = [add stringByAppendingString:[[self.subCellInfo objectAtIndex:[indexPath row] - 1] objectForKey:@"address"]];
        [self.parentTableView.navigationController pushViewController:self.parentTableView.bmvController animated:YES];
        [self.parentTableView.bmvController.mapView addAnnotation:self.parentTableView.bmvController.annotation];
        
        BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.02, 0.02));
        BMKCoordinateRegion adjustedRegion = [self.parentTableView.bmvController.mapView regionThatFits:viewRegion];
        [self.parentTableView.bmvController.mapView setRegion:adjustedRegion animated:YES];
        
        /*
         * google map
        LocationAnnotation *annotation = [LocationAnnotation annotationForLocation:[self.subCellInfo objectAtIndex:[indexPath row] - 1]];
        if (self.parentTableView.mvController.annotation) {
            [self.parentTableView.mvController.mapView removeAnnotation:self.parentTableView.mvController.annotation];
        }
        [self.parentTableView.mvController.mapView addAnnotation:annotation];
        self.parentTableView.mvController.annotation = annotation;
        MKCoordinateRegion region;
        region.center.latitude = annotation.coordinate.latitude;
        region.center.longitude = annotation.coordinate.longitude;
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        region = [self.parentTableView.mvController.mapView regionThatFits:region];
        [self.parentTableView.mvController.mapView setRegion:region animated:YES];
         */
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.subCellNumber == 1)
        return nil;
    UIView *result = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 295, 190)];
    [result setBackgroundColor:[UIColor clearColor]];
    if ([tableView isEqual:self.subTableView] && section == 0){
        UIButton *footerButton;
        UILabel *buttonLabel;
        UIImageView *arrowView = [[UIImageView alloc] init];
        if (!self.isProductExpanded)
        {
            footerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 32, 307, 46)];
            buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 32, 230, 45)];
            self.tinyMapView = [[MKMapView alloc] initWithFrame:CGRectMake(2, 86, 304, 180)];
            UIButton *expandProductBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 2, 300, 30)];
            [expandProductBtn addTarget:self.parentTableView action:@selector(expandProductButtonTapped: withEvent:) forControlEvents:UIControlEventTouchUpInside];
            [expandProductBtn setTitle:@"点击全部展开" forState:UIControlStateNormal];
            [expandProductBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [expandProductBtn.titleLabel setTextColor:[UIColor blackColor]];
            [result addSubview:expandProductBtn];
        }
        else
        {
            footerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 307, 46)];
            buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 230, 45)];
            self.tinyMapView = [[MKMapView alloc] initWithFrame:CGRectMake(2, 56, 304, 180)];
        }
        [footerButton setBackgroundColor:[UIColor clearColor]];
        [footerButton setBackgroundImage:[[UIImage imageNamed:@"blank_title_normal.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)] forState:UIControlStateNormal];
        [footerButton setBackgroundImage:[[UIImage imageNamed:@"blank_title_press.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(30, 30, 30, 30)] forState:UIControlStateHighlighted];
        [footerButton addTarget:self.parentTableView action:@selector(expandMapButtonTapped:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [result addSubview:footerButton];
        NSMutableString *buttonText = [[NSMutableString alloc] initWithString:@""];
        
        if (self.isMapExpanded)
        {
            if (!self.isProductExpanded)
                [arrowView setFrame:CGRectMake(16, 48, 15, 10)];
            else
                [arrowView setFrame:CGRectMake(16, 18, 15, 10)];
            [arrowView setImage:[UIImage imageNamed:@"show_arrow_normal.png"]];
            [buttonText appendString:@"点击隐藏地图"];
        }
        else
        {
            if (!self.isProductExpanded)
                [arrowView setFrame:CGRectMake(16, 48, 10, 15)];
            else
                [arrowView setFrame:CGRectMake(16, 18, 10, 15)];
            [arrowView setImage:[UIImage imageNamed:@"hide_arrow_normal.png"]];
            [buttonText appendString:@"点击展开地图"];
        }
        [result addSubview:arrowView];
        buttonLabel.text = buttonText;
        buttonLabel.font = [UIFont systemFontOfSize:13];
        buttonLabel.backgroundColor = [UIColor clearColor];
        [result addSubview:buttonLabel];
         
        for (int i = 0; i < [self.subCellInfo count]; i++)
        {
            LocationAnnotation *annotation = [LocationAnnotation annotationForLocation:[self.subCellInfo objectAtIndex:i]];
            [self.tinyMapView addAnnotation:annotation];
        }
        MKCoordinateRegion region;
        LocationAnnotation *ann = [self.tinyMapView.annotations lastObject];
        region.center.latitude = ann.coordinate.latitude;
        region.center.longitude = ann.coordinate.longitude;
        region.span.latitudeDelta = 1;
        region.span.longitudeDelta = 1;
        region = [self.tinyMapView regionThatFits:region];
        [self.tinyMapView setRegion:region animated:YES];
        [result addSubview:self.tinyMapView];
    }
    
    return result;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.subCellNumber == 1)
        return 0;
    else if (self.isMapExpanded)
        return 48 + 190;
    else return 50;
}

@end
