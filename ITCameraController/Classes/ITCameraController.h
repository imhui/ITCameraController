//
//  ITCameraController.h
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ITCameraController;
@protocol ITCameraControllerDelegate <NSObject>

- (void)ITCameraController:(ITCameraController *)vc didFinishCameraWithImages:(NSArray *)images;
- (void)ITCameraControllerDidCancel:(ITCameraController *)vc;

@end

@interface ITCameraController : UINavigationController {
    id <ITCameraControllerDelegate> cameraDelegate;
}

@property (nonatomic, assign) id <ITCameraControllerDelegate> cameraDelegate;

- (void)dismissCamera;
- (void)doneWithImages:(NSArray *)images;

@end


