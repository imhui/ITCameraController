//
//  ITCameraController.m
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ITCameraController.h"
#import "ITCameraViewController.h"

@implementation ITCameraController

@synthesize cameraDelegate;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
- (void)dismissCamera {
    [cameraDelegate ITCameraControllerDidCancel:self];
}
- (void)doneWithImages:(NSArray *)images {
    [cameraDelegate ITCameraController:self didFinishCameraWithImages:images];
}


#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    ITCameraViewController *vc = [[ITCameraViewController alloc] initWithNibName:@"ITCameraViewController" bundle:nil];
    self.viewControllers = [NSArray arrayWithObject:vc];
    [vc release];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
