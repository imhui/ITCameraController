//
//  ITViewController.h
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITCameraController.h"

@interface ITViewController : UIViewController <ITCameraControllerDelegate>

- (IBAction)showCamera:(id)sender;

@end
