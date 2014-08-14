//
//  RDMasterViewController.h
//  TestDrawer
//
//  Created by Rohan on 8/13/14.
//  Copyright (c) 2014 Rohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDMasterViewController : UITableViewController <UIViewControllerTransitioningDelegate>

@end

@interface GIOActivityTransitionPush : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;

@end

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>

@end