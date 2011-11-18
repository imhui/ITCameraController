//
//  ITCameraViewController.m
//  ITCameraController
//
//  Created by Li Yonghui on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ITCameraViewController.h"
#import "ITCameraPreviewController.h"
#import "ITCameraController.h"

@interface ITCameraViewController(Private)
- (AVCaptureDeviceInput *)getDeviceInputWidthPosition:(AVCaptureDevicePosition)position;
@end

@implementation ITCameraViewController

@synthesize cameraView, cameraButton, cancelButton, switchButton, cameraCtrView;
@synthesize flashButton, flashOptionAutoButton, flashOptionOnButton, flashOptionOffButton;
@synthesize captureSession, imageOutput;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    
    [cancelButton release];
    [cameraView release];
    [cameraButton release];
    
    [flashButton release];
    [flashOptionAutoButton release];
    [flashOptionOffButton release];
    [flashOptionOnButton release];
    [switchButton release];
    [cameraCtrView release];
    
    [captureSession release];
    [imageOutput release];
    
    [super dealloc];
}


#pragma mark - IBAction
- (IBAction)cameraButtonAction:(id)sender {
    AVCaptureConnection *videoConnection = nil;
//	NSLog(@"connections: %@", imageOutput.connections);
	for (AVCaptureConnection *connection in imageOutput.connections) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		
		if (videoConnection) { 
			break; 
		}
	}
	
//	NSLog(@"about to request a capture from: %@", imageOutput);
	[imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection 
                                             completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
		 CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
		 if (exifAttachments) {
			 NSLog(@"attachements: %@", exifAttachments);
		 }
		 else {
             NSLog(@"no attachments");
         }
		 
		 if (imageSampleBuffer != NULL) {
			 NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
			 UIImage *image = [[UIImage alloc] initWithData:imageData];
			 
			 NSLog(@"image size : %f * %f", image.size.width, image.size.height);
             
             ITCameraPreviewController *vc = [[ITCameraPreviewController alloc] initWithNibName:@"ITCameraPreviewController" bundle:nil];
             vc.image = image;
             [self.navigationController pushViewController:vc animated:YES];
             [vc release];
             
             
             [image release];

		 }
		 
	 }];
}

- (IBAction)cancelButtonAction:(id)sender {
    ITCameraController *nc = (ITCameraController *)self.navigationController;
    [nc dismissCamera];
}

- (IBAction)flashButtonAction:(id)sender {
    flashButton.hidden = YES;
    flashOptionAutoButton.hidden = NO;
    flashOptionOffButton.hidden = NO;
    flashOptionOnButton.hidden = NO;
}

- (IBAction)flashOptionButtonAction:(id)sender {
    AVCaptureDeviceInput *input = [captureSession.inputs objectAtIndex:0];
    AVCaptureDevice *device = input.device;
    if ([device hasFlash]) {
        
        [captureSession beginConfiguration];
        
        NSError *error = nil;
        [device lockForConfiguration:&error];
        if (!error) {
            
            UIButton *btn = (UIButton *)sender;
            if (btn.tag == ITCamera_Flash_Option_Auto) {
                device.flashMode = AVCaptureFlashModeAuto;
                [flashButton setImage:[UIImage imageNamed:@"itcamera_flash_auto"] forState:UIControlStateNormal];
            }
            else if (btn.tag == ITCamera_Flash_Option_On) {
                device.flashMode = AVCaptureFlashModeOn;
                [flashButton setImage:[UIImage imageNamed:@"itcamera_flash_on"] forState:UIControlStateNormal];
            }
            else if (btn.tag == ITCamera_Flash_Option_Off) {
                device.flashMode = AVCaptureFlashModeOff;
                [flashButton setImage:[UIImage imageNamed:@"itcamera_flash_off"] forState:UIControlStateNormal];
            }
        }
        
        [captureSession commitConfiguration];
    }
    
    flashOptionAutoButton.hidden = YES;
    flashOptionOnButton.hidden = YES;
    flashOptionOffButton.hidden = YES;
    flashButton.hidden = NO;
}

- (IBAction)switchButtonAction:(id)sender {
    
    AVCaptureDeviceInput *input = [captureSession.inputs objectAtIndex:0];
    AVCaptureDevice *device = input.device;
    AVCaptureDeviceInput *newInput = nil;
    if (device.position == AVCaptureDevicePositionFront) {
        newInput = [self getDeviceInputWidthPosition:AVCaptureDevicePositionBack];
    } else if (device.position == AVCaptureDevicePositionBack) {
        newInput = [self getDeviceInputWidthPosition:AVCaptureDevicePositionFront];
    }
    
    if (newInput != nil) {
        [captureSession beginConfiguration];
        [captureSession removeInput:input];
        [captureSession addInput:newInput];
        [captureSession commitConfiguration];
    }
}


- (AVCaptureDeviceInput *)getDeviceInputWidthPosition:(AVCaptureDevicePosition)position {
    AVCaptureDeviceInput *input = nil;
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            NSError *error = nil;
            if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                [device lockForConfiguration:&error];
                if (!error) {
                    CGPoint autofocusPoint = CGPointMake(0.5f, 0.5f);
                    [device setFocusPointOfInterest:autofocusPoint];
                    [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
                }
                [device unlockForConfiguration];
                error = nil;
            }
            input = [[[AVCaptureDeviceInput alloc] initWithDevice:device error:&error] autorelease];
            break;
        }
    }
    
    return input;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.captureSession = session;
    [session release];
    captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    
    CALayer *layer = self.cameraView.layer;
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    previewLayer.frame = cameraView.bounds;
    [layer addSublayer:previewLayer];
    [previewLayer release];
    
    NSError *error = nil;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
        [device lockForConfiguration:&error];
        if (!error) {
            CGPoint autofocusPoint = CGPointMake(0.5f, 0.5f);
            [device setFocusPointOfInterest:autofocusPoint];
            [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        }
        [device unlockForConfiguration];
        error = nil;
    }
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (!input) {
        NSLog(@"init device input error");
    }
    [captureSession addInput:input];
    [input release];
    
    AVCaptureStillImageOutput *output = [[AVCaptureStillImageOutput alloc] init];
    self.imageOutput = output;
    [output release];
    
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
	[imageOutput setOutputSettings:outputSettings];
	[outputSettings release];
    [captureSession addOutput:imageOutput];
    
    [self.view addSubview:cameraCtrView];
    [captureSession startRunning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.cameraView = nil;
    self.cameraButton = nil;
    self.cancelButton = nil;
    self.flashButton = nil;
    self.flashOptionAutoButton = nil;
    self.flashOptionOffButton = nil;
    self.flashOptionOnButton = nil;
    self.cameraCtrView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
