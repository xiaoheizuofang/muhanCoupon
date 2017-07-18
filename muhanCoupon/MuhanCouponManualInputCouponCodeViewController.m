/*
 * Copyright 2015-present, Morphling, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "MuhanCouponManualInputCouponCodeViewController.h"

#import "MuhanCouponPasswordViewController.h"

@interface MuhanCouponManualInputCouponCodeViewController ()

@property UIButton *redeemingButton;
@property UIButton *gobackButton;
@property UITextField *couponCodeInputTextField;

@end

@implementation MuhanCouponManualInputCouponCodeViewController {
}

- (instancetype)init {
    if ((self = [super initWithNibName:nil bundle:nil])) {
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:170.0/255.0f green:130.0/255.0f blue:125.0/255.0f alpha:1.0f];
    
    self.couponCodeInputTextField = [[UITextField alloc] init];
    [self.couponCodeInputTextField setPlaceholder:@"输入兑换码"];
    [self.couponCodeInputTextField setFrame:CGRectMake(60,
                                                       60,
                                                       self.view.frame.size.width - 60 * 2,
                                                       60)];
    self.couponCodeInputTextField.backgroundColor = [UIColor whiteColor];
    [self.couponCodeInputTextField.layer setBorderColor:[UIColor greenColor].CGColor];
    [self.couponCodeInputTextField.layer setBorderWidth:2.0f];
    [self.couponCodeInputTextField.layer setCornerRadius:5.0f];
    [self.view addSubview:self.couponCodeInputTextField];
    
    self.redeemingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.redeemingButton setTitle:@"兑换消费券" forState:UIControlStateNormal];
    [self.redeemingButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.redeemingButton.layer setBorderWidth:2.0f];
    [self.redeemingButton.layer setCornerRadius:5.0f];
    [self.redeemingButton sizeToFit];
    [self.redeemingButton setFrame:CGRectMake(self.redeemingButton.frame.origin.x - self.redeemingButton.frame.size.width / 2,
                                              self.redeemingButton.frame.origin.y,
                                              self.redeemingButton.frame.size.width * 2,
                                              self.redeemingButton.frame.size.height)];
    [self.view addSubview:self.redeemingButton];
    [self.redeemingButton addTarget:self action:@selector(didTapRedeemingButton) forControlEvents:UIControlEventTouchUpInside];

    self.gobackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.gobackButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.gobackButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.gobackButton.layer setBorderWidth:2.0f];
    [self.gobackButton.layer setCornerRadius:5.0f];
    [self.gobackButton sizeToFit];
    [self.gobackButton setFrame:CGRectMake(self.gobackButton.frame.origin.x - self.gobackButton.frame.size.width / 2,
                                           self.gobackButton.frame.origin.y,
                                           self.gobackButton.frame.size.width * 2,
                                           self.gobackButton.frame.size.height)];
    [self.view addSubview:self.gobackButton];
    [self.gobackButton addTarget:self action:@selector(didTapGoBackButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.redeemingButton.center = CGPointMake(self.view.frame.size.width * 0.5f,
                                              self.view.frame.size.height * 0.5f);
    self.gobackButton.center = CGPointMake(self.gobackButton.frame.size.width * 0.6f,
                                           [[UIApplication sharedApplication] statusBarFrame].size.height + self.gobackButton.frame.size.height);
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - actions

- (void)didTapRedeemingButton {
    MuhanCouponPasswordViewController* passwordViewController = [[MuhanCouponPasswordViewController alloc] init];
    [self presentViewController:passwordViewController animated:YES completion:^{
    }];
}

- (void)didTapGoBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
