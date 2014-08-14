//
//  RDDetailViewController.m
//  TestDrawer
//
//  Created by Rohan on 8/13/14.
//  Copyright (c) 2014 Rohan. All rights reserved.
//

#import "RDDetailViewController.h"

@interface RDDetailViewController ()
- (void)configureView;
@end

@implementation RDDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self configureView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 100, 100, 100);
    [self.view addSubview:button];
    self.view.backgroundColor = [UIColor blueColor];

}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
