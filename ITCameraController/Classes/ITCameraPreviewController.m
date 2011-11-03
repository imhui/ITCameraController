//
//  ITCameraPreviewController.m
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ITCameraPreviewController.h"
#import "ITCameraController.h"

@implementation ITCameraPreviewController
@synthesize imageView, image;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [imageView release];
    [image release];
    [super dealloc];
}

#pragma mark - IBAction
- (IBAction)reTakeAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender {
    ITCameraController *nc = (ITCameraController *)self.navigationController;
    [nc doneWithImages:[NSArray arrayWithObject:image]];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    imageView.image = image;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.imageView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
