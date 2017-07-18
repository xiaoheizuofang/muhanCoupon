/*
 * Copyright 2015-present, Morphling, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <AVFoundation/AVFoundation.h>

#import "MuhanCouponScanQRCodeViewController.h"
#import "MuhanCouponManualInputCouponCodeViewController.h"

static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface MuhanCouponScanQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property UIButton *cancelButton;
@property UIButton *manualInputButton;

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation MuhanCouponScanQRCodeViewController {
}

- (instancetype)init {
    if ((self = [super initWithNibName:nil bundle:nil])) {
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:170.0/255.0f green:130.0/255.0f blue:125.0/255.0f alpha:1.0f];
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.cancelButton.layer setBorderWidth:2.0f];
    [self.cancelButton.layer setCornerRadius:5.0f];
    [self.cancelButton sizeToFit];
    [self.cancelButton setFrame:CGRectMake(self.cancelButton.frame.origin.x - self.cancelButton.frame.size.width / 2,
                                           self.cancelButton.frame.origin.y,
                                           self.cancelButton.frame.size.width * 2,
                                           self.cancelButton.frame.size.height)];
    [self.view addSubview:self.cancelButton];
    [self.cancelButton addTarget:self action:@selector(didTapCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.manualInputButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.manualInputButton setTitle:@"手动输入兑换码" forState:UIControlStateNormal];
    [self.manualInputButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.manualInputButton.layer setBorderWidth:2.0f];
    [self.manualInputButton.layer setCornerRadius:5.0f];
    [self.manualInputButton sizeToFit];
    [self.manualInputButton setFrame:CGRectMake(self.manualInputButton.frame.origin.x - self.manualInputButton.frame.size.width / 2,
                                                  self.manualInputButton.frame.origin.y,
                                                  self.manualInputButton.frame.size.width * 2,
                                                  self.manualInputButton.frame.size.height)];
    [self.view addSubview:self.manualInputButton];
    [self.manualInputButton addTarget:self action:@selector(didTapManualInputCodeButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self startReading];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.cancelButton.center = CGPointMake(self.view.frame.size.width - self.cancelButton.frame.size.width,
                                           [[UIApplication sharedApplication] statusBarFrame].size.height + self.cancelButton.frame.size.height);
    self.manualInputButton.center = CGPointMake(self.view.frame.size.width * 0.5f,
                                                self.view.frame.size.height * 0.8f);
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - actions

- (void)didTapCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapManualInputCodeButton {
    MuhanCouponManualInputCouponCodeViewController* manualInputCodeViewController = [[MuhanCouponManualInputCouponCodeViewController alloc] init];
    [self presentViewController:manualInputCodeViewController animated:YES completion:^{}];
}

#pragma mark - Scan QR Code

- (void)startReading {
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];

    BOOL hasLayer = NO;
    if (_videoPreviewLayer) {
        hasLayer = YES;
    }
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    if (hasLayer) {
        [self.view.layer replaceSublayer:self.view.layer.sublayers[0] with:_videoPreviewLayer];
    } else {
        [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    }
    
    [_captureSession startRunning];
}

- (void)stopReading {
    [_captureSession stopRunning];
    _captureSession = nil;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"结果"
                                                                           message:result
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                                        [self startReading];
                                                    }]];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSLog(@"不是二维码");
        }
        [self stopReading];
    }
}

@end
