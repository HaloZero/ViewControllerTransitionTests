//
//  RDMasterViewController.m
//  TestDrawer
//
//  Created by Rohan on 8/13/14.
//  Copyright (c) 2014 Rohan. All rights reserved.
//

#import "RDMasterViewController.h"

#import "RDDetailViewController.h"

@interface RDMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation RDMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"view will appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"View will dissapear");
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [Animator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [Animator new];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *detailViewController = [[RDDetailViewController alloc] init];
    UINavigationController *navContorller = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    navContorller.transitioningDelegate = self;
    navContorller.modalPresentationStyle =  UIModalPresentationCustom;
    [self presentViewController:navContorller animated:YES completion:nil];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end

@implementation GIOActivityTransitionPush

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *transitionContextContainer = [transitionContext containerView];
    if (self.presenting) {
        [transitionContextContainer addSubview:fromViewController.view];
        [transitionContextContainer addSubview:toViewController.view];

        // should start off screen
        CGRect startFrame = [UIScreen mainScreen].bounds;
        startFrame.origin.x = startFrame.size.width;
        toViewController.view.frame = startFrame;

        // final position should be the main screen
        CGRect endFrame = [UIScreen mainScreen].bounds;

        [UIView animateWithDuration:0.6f
                              delay:0.0f
             usingSpringWithDamping:0.7f
              initialSpringVelocity:0.5f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ toViewController.view.frame = endFrame; }
                         completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
    } else {
        [transitionContextContainer addSubview:toViewController.view];
        [transitionContextContainer addSubview:fromViewController.view];

        // starts out visible
        CGRect startFrame = [UIScreen mainScreen].bounds;
        fromViewController.view.frame = startFrame;

        // final position should be the offset from the main screen
        CGRect endFrame = [UIScreen mainScreen].bounds;
        endFrame.origin.x = endFrame.size.width;

        [UIView animateWithDuration:0.6f
                              delay:0.0f
             usingSpringWithDamping:0.7f
              initialSpringVelocity:0.5f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ fromViewController.view.frame = endFrame; }
                         completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
    }
}

@end

//
//  Animator.m
//  NavigationTransitionTest
//
//  Created by Chris Eidhof on 9/27/13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

@implementation Animator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }];
}

@end