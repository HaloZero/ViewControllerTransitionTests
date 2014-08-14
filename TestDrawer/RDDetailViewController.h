//
//  RDDetailViewController.h
//  TestDrawer
//
//  Created by Rohan on 8/13/14.
//  Copyright (c) 2014 Rohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
