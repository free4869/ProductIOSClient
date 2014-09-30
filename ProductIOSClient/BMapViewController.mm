//
//  BMapViewController.m
//  ProductIOSClient
//
//  Created by Shao Wei on 9/6/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "BMapViewController.h"

@interface BMapViewController ()

@end

@implementation BMapViewController

@synthesize mapView = _mapView;
@synthesize annotation = _annotation;
@synthesize bubbleView = _bubbleView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{   
    [super viewDidLoad];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight - 60)];
    [self.view addSubview:self.mapView];
    self.mapView.delegate = self;                     
    self.mapView.showsUserLocation = YES;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_nomal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_pressed.png"] forState:UIControlStateHighlighted];
    [backButton setBackgroundColor:[UIColor clearColor]];
    backButton.frame = CGRectMake(20, 40, 60, 60);
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back_nomal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundColor:[UIColor clearColor]];
    backButton.frame = CGRectMake(20, 40, 60, 60);
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
        [newAnnotationView setImage:[UIImage imageNamed:@"icon_mark.png"]];
        newAnnotationView.selected = YES;
        newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

@end
