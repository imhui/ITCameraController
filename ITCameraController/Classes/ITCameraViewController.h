//
//  ITCameraViewController.h
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

typedef enum {
    ITCamera_Flash_Option_Auto = 100,
    ITCamera_Flash_Option_On = 101,
    ITCamera_Flash_Option_Off = 102
} ITCamera_Flash_Option;

@interface ITCameraViewController : UIViewController {
    
    IBOutlet UIView *cameraView;
    IBOutlet UIButton *cameraButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UIView *cameraCtrView;
    IBOutlet UIButton *flashButton;
    IBOutlet UIButton *flashOptionAutoButton;
    IBOutlet UIButton *flashOptionOnButton;
    IBOutlet UIButton *flashOptionOffButton;
    IBOutlet UIButton *switchButton;
    
    AVCaptureSession *captureSession;
    AVCaptureStillImageOutput *imageOutput;
}

@property (nonatomic, retain) IBOutlet UIView *cameraView;
@property (nonatomic, retain) IBOutlet UIButton *cameraButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) IBOutlet UIView *cameraCtrView;
@property (nonatomic, retain) IBOutlet UIButton *flashButton;
@property (nonatomic, retain) IBOutlet UIButton *flashOptionAutoButton;
@property (nonatomic, retain) IBOutlet UIButton *flashOptionOnButton;
@property (nonatomic, retain) IBOutlet UIButton *flashOptionOffButton;
@property (nonatomic, retain) IBOutlet UIButton *switchButton;

@property (nonatomic, retain) AVCaptureSession *captureSession;
@property (nonatomic, retain) AVCaptureStillImageOutput *imageOutput;

- (IBAction)cameraButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)flashButtonAction:(id)sender;
- (IBAction)flashOptionButtonAction:(id)sender;
- (IBAction)switchButtonAction:(id)sender;

@end
