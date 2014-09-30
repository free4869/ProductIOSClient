//
//  StartViewController.m
//  ProductIOSClient
//
//  Created by Shao Wei on 7/3/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize imageView = _imageView;

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
     UIImageView *titleBarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bar_bg.jpg"]];
     titleBarView.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
     titleBarView.contentMode = UIViewContentModeScaleToFill;
     [self.navigationController.navigationBar addSubview:titleBarView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    int random = arc4random() % 9 + 1;
    NSMutableString *imageName = [[NSMutableString alloc] initWithFormat:@"welcome_bg_%i.JPG", random];
    UIImage *bgImage = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContext(CGSizeMake(bgImage.size.width * 0.45, bgImage.size.height * 0.4));
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width * 0.45, bgImage.size.height * 0.4)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:scaledImage]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
