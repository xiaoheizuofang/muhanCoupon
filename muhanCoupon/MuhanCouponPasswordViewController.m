/*
 * Copyright 2015-present, Morphling, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "MuhanCouponPasswordViewController.h"

@interface MuhanCouponPasswordViewController ()

@property UIButton *confirmButton;
@property UITextField *passwordInputTextField;

@end

@implementation MuhanCouponPasswordViewController {
}

- (instancetype)init {
    if ((self = [super initWithNibName:nil bundle:nil])) {
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:170.0/255.0f green:130.0/255.0f blue:125.0/255.0f alpha:1.0f];
    
    self.passwordInputTextField = [[UITextField alloc] init];
    [self.passwordInputTextField setPlaceholder:@"输入管理员密码"];
    [self.passwordInputTextField setFrame:CGRectMake(60,
                                                     60,
                                                     self.view.frame.size.width - 60 * 2,
                                                     60)];
    self.passwordInputTextField.backgroundColor = [UIColor whiteColor];
    [self.passwordInputTextField.layer setBorderColor:[UIColor greenColor].CGColor];
    [self.passwordInputTextField.layer setBorderWidth:2.0f];
    [self.passwordInputTextField.layer setCornerRadius:5.0f];
    [self.view addSubview:self.passwordInputTextField];
    
    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.confirmButton.layer setBorderWidth:2.0f];
    [self.confirmButton.layer setCornerRadius:5.0f];
    [self.confirmButton sizeToFit];
    [self.confirmButton setFrame:CGRectMake(self.confirmButton.frame.origin.x - self.confirmButton.frame.size.width / 2,
                                            self.confirmButton.frame.origin.y,
                                            self.confirmButton.frame.size.width * 2,
                                            self.confirmButton.frame.size.height)];
    [self.view addSubview:self.confirmButton];
    [self.confirmButton addTarget:self action:@selector(didTapConfirmButton) forControlEvents:UIControlEventTouchUpInside];    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.confirmButton.center = CGPointMake(self.view.frame.size.width * 0.5f,
                                            self.view.frame.size.height * 0.5f);
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - actions

- (void)didTapConfirmButton {
    NSString *password = self.passwordInputTextField.text;
    if ([password isEqualToString:@"muhan"]) {
        
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"密码错误"
                                                                                 message:@"找你老板问她要密码"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        [alertController addAction:okAction];
        [self presentViewController:alertController
                           animated:YES
                         completion:^{
                             
                         }];
    }
}

@end
