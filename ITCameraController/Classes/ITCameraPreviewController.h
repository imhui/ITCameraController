//
//  ITCameraPreviewController.h
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITCameraPreviewController : UIViewController {
    IBOutlet UIImageView *imageView;
    UIImage *image;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;

- (IBAction)reTakeAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end
