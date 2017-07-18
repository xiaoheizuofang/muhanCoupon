/*
 * Copyright 2015-present, Morphling, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppRootViewController.h"

#import "MuhanCouponScanQRCodeViewController.h"

@interface AppRootViewController ()

@property UIButton *startRedeemingButton;
@property UIButton *checkingStockButton;

@end

@implementation AppRootViewController {
}

- (instancetype)initWithHelloString:(NSString *)helloString {
    if ((self = [super initWithNibName:nil bundle:nil])) {
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:70.0/255.0f green:130.0/255.0f blue:125.0/255.0f alpha:1.0f];
    
    self.startRedeemingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.startRedeemingButton setTitle:@"兑换消费券" forState:UIControlStateNormal];
    [self.startRedeemingButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.startRedeemingButton.layer setBorderWidth:2.0f];
    [self.startRedeemingButton.layer setCornerRadius:5.0f];
    [self.startRedeemingButton sizeToFit];
    [self.startRedeemingButton setFrame:CGRectMake(self.startRedeemingButton.frame.origin.x - self.startRedeemingButton.frame.size.width / 2,
                                          self.startRedeemingButton.frame.origin.y,
                                          self.startRedeemingButton.frame.size.width * 2,
                                          self.startRedeemingButton.frame.size.height)];
    [self.view addSubview:self.startRedeemingButton];
    [self.startRedeemingButton addTarget:self action:@selector(didTapStartRedeemingButton) forControlEvents:UIControlEventTouchUpInside];

    self.checkingStockButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.checkingStockButton setTitle:@"管理库存" forState:UIControlStateNormal];
    [self.checkingStockButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.checkingStockButton.layer setBorderWidth:2.0f];
    [self.checkingStockButton.layer setCornerRadius:5.0f];
    [self.checkingStockButton sizeToFit];
    [self.checkingStockButton setFrame:CGRectMake(self.checkingStockButton.frame.origin.x - self.checkingStockButton.frame.size.width / 2,
                                                   self.checkingStockButton.frame.origin.y,
                                                   self.checkingStockButton.frame.size.width * 2,
                                                   self.checkingStockButton.frame.size.height)];
    [self.view addSubview:self.checkingStockButton];
    [self.checkingStockButton addTarget:self action:@selector(didTapCheckingStockButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.startRedeemingButton.center = CGPointMake(self.view.frame.size.width * 0.5f,
                                                   self.view.frame.size.height * 0.8f);
    self.checkingStockButton.center = CGPointMake(self.view.frame.size.width * 0.5f,
                                                  self.startRedeemingButton.frame.origin.y + self.startRedeemingButton.frame.size.height * 2);
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - actions

- (void)didTapStartRedeemingButton {
    MuhanCouponScanQRCodeViewController* scanQRCodeViewController = [[MuhanCouponScanQRCodeViewController alloc] init];
    [self presentViewController:scanQRCodeViewController animated:YES completion:^{
    }];
}

- (void)didTapCheckingStockButton {
}

@end
