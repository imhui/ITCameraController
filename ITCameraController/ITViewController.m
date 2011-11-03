//
//  ITViewController.m
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ITViewController.h"

@implementation ITViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)showCamera:(id)sender {
    ITCameraController *vc = [[ITCameraController alloc] init];
    vc.cameraDelegate = self;
    [self presentModalViewController:vc animated:YES];
    [vc release];
}

#pragma mark - ITCameraControllerDelegate
- (void)ITCameraController:(ITCameraController *)vc didFinishCameraWithImages:(NSArray *)images {
    NSLog(@"images: %@", images);
    [self dismissModalViewControllerAnimated:YES];
}

- (void)ITCameraControllerDidCancel:(ITCameraController *)vc {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
